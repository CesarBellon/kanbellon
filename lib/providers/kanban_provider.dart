import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../models/app_data.dart';
import '../models/workspace.dart';
import '../models/kanban_board.dart';
import '../models/kanban_list.dart';
import '../models/kanban_card.dart';
import '../services/persistence_factory.dart';
import '../services/persistence_service.dart';
import '../services/cloud_service.dart';
import 'kanban_state.dart';

part 'kanban_provider.g.dart';

@Riverpod(keepAlive: true)
PersistenceService persistenceService(Ref ref) {
  return getPlatformPersistenceService();
}

@Riverpod(keepAlive: true)
class KanbanNotifier extends _$KanbanNotifier {
  late final PersistenceService _persistence;
  final CloudService _cloudService = CloudService();
  final _uuid = const Uuid();

  @override
  KanbanState build() {
    _persistence = ref.read(persistenceServiceProvider);
    _init();
    return const KanbanState(isLoading: true);
  }

  Future<void> _init() async {
    try {
      await _persistence.init();
      await _cloudService.init(); // Restore Drive session if available
      final isConfig = await _persistence.isConfigured();
      
      final loadedData = await _persistence.load();
      if (loadedData != null) {
        state = state.copyWith(data: loadedData, isLoading: false, isConfigured: isConfig);
        // Auto-select first workspace and board if available
        if (loadedData.workspaces.isNotEmpty) {
           final firstWs = loadedData.workspaces.first;
           state = state.copyWith(selectedWorkspaceId: firstWs.id);
           if (firstWs.boards.isNotEmpty) {
             state = state.copyWith(selectedBoardId: firstWs.boards.first.id);
           }
        }
      } else {
        // Create default workspace if empty
        final defaultWs = Workspace(id: _uuid.v4(), title: 'My Workspace', boards: []);
        final newData = AppData(workspaces: [defaultWs]);
        state = state.copyWith(
            data: newData, 
            isLoading: false,
            selectedWorkspaceId: defaultWs.id,
            isConfigured: isConfig
        );
        // Only save if configured, or trigger config? 
        // We can't save if not configured on Desktop.
        if (isConfig) {
            _save();
        }
      }
    } catch (e, st) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print(e);
      print(st);
    }
  }
  
  Future<void> setPersistencePath(String path) async {
       await _persistence.setPath(path);
       state = state.copyWith(isConfigured: true);
       _save();
  }

  Future<void> _save() async {
    await _persistence.save(state.data);
    if (_cloudService.isSignedIn) {
        await _cloudService.uploadData(state.data);
    }
  }

  Future<void> exportData() async {
    await _persistence.exportData(state.data);
  }

  // Cloud Methods
  Future<void> signInToDrive(String clientId, String clientSecret) async {
      try {
          await _cloudService.signIn(clientId, clientSecret);
          // Try sync immediately?
      } catch (e) {
          state = state.copyWith(error: "Drive Sign In failed: $e");
      }
  }

  Future<void> syncFromCloud() async {
      if (!_cloudService.isSignedIn) return;
      try {
          final cloudData = await _cloudService.downloadData();
          if (cloudData != null) {
              state = state.copyWith(data: cloudData);
              _save(); // Sync back to local
          }
      } catch (e) {
          state = state.copyWith(error: "Cloud Sync failed: $e");
      }
  }
  
  bool get isCloudSignedIn => _cloudService.isSignedIn;

  Future<void> importData() async {
    try {
      final data = await _persistence.importData();
      if (data != null) {
        String? newWsId;
        String? newBoardId;
        
        if (data.workspaces.isNotEmpty) {
            newWsId = data.workspaces.first.id;
            if (data.workspaces.first.boards.isNotEmpty) {
                newBoardId = data.workspaces.first.boards.first.id;
            }
        }
        
        state = state.copyWith(
            data: data,
            selectedWorkspaceId: newWsId,
            selectedBoardId: newBoardId
        );
        _save();
      }
    } catch (e) {
      rethrow; 
    }
  }

  // selection logic
  void selectWorkspace(String id) {
    state = state.copyWith(selectedWorkspaceId: id, selectedBoardId: null);
    // optionally select first board
    final ws = state.data.workspaces.firstWhere((w) => w.id == id);
    if (ws.boards.isNotEmpty) {
       state = state.copyWith(selectedBoardId: ws.boards.first.id);
    }
  }

  void selectBoard(String id) {
    state = state.copyWith(selectedBoardId: id);
  }
  
  // Workspace CRUD
  void addWorkspace(String title) {
    final newWs = Workspace(id: _uuid.v4(), title: title);
    state = state.copyWith(
        data: state.data.copyWith(
            workspaces: [...state.data.workspaces, newWs]
        )
    );
    selectWorkspace(newWs.id);
    _save();
  }
  
  void deleteWorkspace(String id) {
    state = state.copyWith(
      data: state.data.copyWith(
        workspaces: state.data.workspaces.where((w) => w.id != id).toList()
      )
    );
    if (state.selectedWorkspaceId == id) {
      state = state.copyWith(selectedWorkspaceId: null, selectedBoardId: null);
    }
    _save();
  }

  // Board CRUD
  void addBoard(String title) {
    if (state.selectedWorkspaceId == null) return;
    
    final newBoard = KanbanBoard(id: _uuid.v4(), title: title);
    
    state = state.copyWith(
        data: state.data.copyWith(
            workspaces: state.data.workspaces.map((ws) {
                if (ws.id == state.selectedWorkspaceId) {
                    return ws.copyWith(boards: [...ws.boards, newBoard]);
                }
                return ws;
            }).toList()
        )
    );
    selectBoard(newBoard.id);
    _save();
  }
  
  void deleteBoard(String boardId) {
     if (state.selectedWorkspaceId == null) return;
     
     state = state.copyWith(
        data: state.data.copyWith(
            workspaces: state.data.workspaces.map((ws) {
                if (ws.id == state.selectedWorkspaceId) {
                    return ws.copyWith(
                        boards: ws.boards.where((b) => b.id != boardId).toList()
                    );
                }
                return ws;
            }).toList()
        )
    );
    
    if (state.selectedBoardId == boardId) {
      state = state.copyWith(selectedBoardId: null);
    }
    _save();
  }

  void renameBoard(String boardId, String newTitle) {
      if (state.selectedWorkspaceId == null) return;
      
      state = state.copyWith(
          data: state.data.copyWith(
              workspaces: state.data.workspaces.map((ws) {
                  if (ws.id == state.selectedWorkspaceId) {
                      return ws.copyWith(boards: ws.boards.map((b) {
                          if (b.id == boardId) {
                              return b.copyWith(title: newTitle);
                          }
                          return b;
                      }).toList());
                  }
                  return ws;
              }).toList()
          )
      );
      _save();
  }

  // List CRUD
  void addList(String title) {
    if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;

    final newList = KanbanList(id: _uuid.v4(), title: title);

    _updateCurrentBoard((board) {
        return board.copyWith(lists: [...board.lists, newList]);
    });
  }
  
  void deleteList(String listId) {
    if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;
    
    _updateCurrentBoard((board) {
        return board.copyWith(lists: board.lists.where((l) => l.id != listId).toList());
    });
  }

  void renameList(String listId, String newTitle) {
    if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;

    _updateCurrentBoard((board) {
      return board.copyWith(
        lists: board.lists.map((l) {
          if (l.id == listId) {
            return l.copyWith(title: newTitle);
          }
          return l;
        }).toList(),
      );
    });
  }

  // Card CRUD
  void addCard(String listId, String title, String description, {String? imageBase64}) {
    if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;

    final newCard = KanbanCard(
        id: _uuid.v4(), 
        title: title, 
        description: description,
        imageBase64: imageBase64
    );
    
    _updateCurrentBoard((board) {
        return board.copyWith(
            lists: board.lists.map((list) {
                if (list.id == listId) {
                    return list.copyWith(cards: [...list.cards, newCard]);
                }
                return list;
            }).toList()
        );
    });
  }

  void updateCard(String listId, KanbanCard updatedCard) {
    if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;
      _updateCurrentBoard((board) {
        return board.copyWith(
            lists: board.lists.map((list) {
                if (list.id == listId) {
                    return list.copyWith(cards: list.cards.map((c) => c.id == updatedCard.id ? updatedCard : c).toList());
                }
                return list;
            }).toList()
        );
    });
  }
  
  void deleteCard(String listId, String cardId) {
      if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;
      
      _updateCurrentBoard((board) {
        return board.copyWith(
            lists: board.lists.map((list) {
                if (list.id == listId) {
                    return list.copyWith(cards: list.cards.where((c) => c.id != cardId).toList());
                }
                return list;
            }).toList()
        );
    });
  }

  // Move Card
  void moveCard(KanbanCard card, String fromListId, String toListId, int newIndex) {
      if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;
      
      _updateCurrentBoard((board) {
          // Deep copy logic would be better, but we are reconstructing mostly
          
          // 1. Remove from old list
          List<KanbanList> newLists = board.lists.map((list) {
             if (list.id == fromListId) {
                 return list.copyWith(cards: list.cards.where((c) => c.id != card.id).toList());
             }
             return list;
          }).toList();
          
          // 2. Insert into new list
          newLists = newLists.map((list) {
              if (list.id == toListId) {
                   final updatedCards = List<KanbanCard>.from(list.cards);
                   if (newIndex >= updatedCards.length) {
                       updatedCards.add(card);
                   } else {
                       updatedCards.insert(newIndex, card);
                   }
                   return list.copyWith(cards: updatedCards);
              }
              return list;
          }).toList();
          
          return board.copyWith(lists: newLists);
      });
  }

  void moveCardCrossBoard(
      KanbanCard card, 
      String fromWsId, 
      String fromBoardId, 
      String fromListId, 
      String toWsId, 
      String toBoardId, 
      String toListId
  ) {
      if (fromWsId == toWsId && fromBoardId == toBoardId) {
          // Same board move, maybe different list
          // Just use moveCard but we need index. MoveCard expects index.
          // This method is from Dialog, so append to end of list usually.
          
          final ws = state.data.workspaces.firstWhere((w) => w.id == fromWsId);
          final board = ws.boards.firstWhere((b) => b.id == fromBoardId);
          final toList = board.lists.firstWhere((l) => l.id == toListId);
          
          moveCard(card, fromListId, toListId, toList.cards.length);
          return;
      }

      // Cross-board or Cross-workspace logic
      // 1. Remove from source
      final newWorkspaces = state.data.workspaces.map((ws) {
          if (ws.id == fromWsId) {
              return ws.copyWith(boards: ws.boards.map((board) {
                   if (board.id == fromBoardId) {
                       return board.copyWith(lists: board.lists.map((list) {
                           if (list.id == fromListId) {
                               return list.copyWith(cards: list.cards.where((c) => c.id != card.id).toList());
                           }
                           return list;
                       }).toList());
                   }
                   return board;
              }).toList());
          }
          return ws;
      }).toList();

      // 2. Add to destination
      final finalWorkspaces = newWorkspaces.map((ws) {
          if (ws.id == toWsId) {
              return ws.copyWith(boards: ws.boards.map((board) {
                   if (board.id == toBoardId) {
                       return board.copyWith(lists: board.lists.map((list) {
                           if (list.id == toListId) {
                               return list.copyWith(cards: [...list.cards, card]);
                           }
                           return list;
                       }).toList());
                   }
                   return board;
              }).toList());
          }
          return ws;
      }).toList();
      
      state = state.copyWith(data: state.data.copyWith(workspaces: finalWorkspaces));
      _save();
  }
  
  // Helper to update specific board in structure
  void _updateCurrentBoard(KanbanBoard Function(KanbanBoard) updater) {
      state = state.copyWith(
        data: state.data.copyWith(
            workspaces: state.data.workspaces.map((ws) {
                if (ws.id == state.selectedWorkspaceId) {
                    return ws.copyWith(
                        boards: ws.boards.map((b) {
                            if (b.id == state.selectedBoardId) {
                                return updater(b);
                            }
                            return b;
                        }).toList()
                    );
                }
                return ws;
            }).toList()
        )
      );
      _save();
  }
}
