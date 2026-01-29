import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/kanban_provider.dart';
import '../../models/kanban_board.dart';
import '../../models/kanban_card.dart';
import '../widgets/kanban_list_widget.dart';
import '../widgets/card_dialog.dart';
import '../widgets/move_card_dialog.dart';

class BoardView extends ConsumerWidget {
  final String boardId;
  final VoidCallback? onToggleSidebar;
  final bool isSidebarOpen;

  const BoardView({
    super.key, 
    required this.boardId, 
    this.onToggleSidebar,
    this.isSidebarOpen = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ... (existing code finding board) ...
    final kanbanState = ref.watch(kanbanProvider);
    final notifier = ref.read(kanbanProvider.notifier);
    
    // Find the board
    KanbanBoard? currentBoard;
    for (final ws in kanbanState.data.workspaces) {
        if (ws.id == kanbanState.selectedWorkspaceId) {
            for (final b in ws.boards) {
                if (b.id == boardId) {
                    currentBoard = b;
                    break;
                }
            }
        }
    }

    if (currentBoard == null) {
        return const Center(child: Text("Board not found"));
    }

    return Scaffold(
         backgroundColor: Colors.transparent,
         appBar: AppBar(
             leading: onToggleSidebar != null 
                ? IconButton(
                    icon: Icon(isSidebarOpen ? Icons.menu_open : Icons.menu),
                    onPressed: onToggleSidebar,
                    tooltip: isSidebarOpen ? "Close Sidebar" : "Open Sidebar",
                  )
                : null,
             title: InkWell(
                 onTap: () => _showRenameBoardDialog(context, ref, currentBoard!.id, currentBoard.title),
                 borderRadius: BorderRadius.circular(8),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Text(currentBoard.title),
                     const SizedBox(width: 8),
                     const Icon(Icons.edit, size: 16, color: Colors.grey),
                   ],
                 ),
             ),
             backgroundColor: Colors.transparent,
             elevation: 0,
             actions: [
                 IconButton(
                     onPressed: () => _showAddListDialog(context, ref),
                     icon: const Icon(Icons.add_box),
                     tooltip: "Add List",
                 )
             ],
         ),
         body: Scrollbar(
             thumbVisibility: true,
             child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 padding: const EdgeInsets.all(16),
                 itemCount: currentBoard.lists.length,
                 itemBuilder: (context, index) {

                     
                     final list = currentBoard!.lists[index];
                     return KanbanListWidget(
                         list: list,
                         onAddCard: () => _showAddCardDialog(context, ref, list.id),
                         onDeleteList: (id) => notifier.deleteList(id),
                         onDeleteCard: (card) => notifier.deleteCard(list.id, card.id),
                         onCardTap: (card) => _showEditCardDialog(context, ref, list.id, card),
                         onRequestMove: (card) => _showMoveCardDialog(context, ref, list.id, card),
                         onCardReceived: (card, fromListId, newIndex) {
                             notifier.moveCard(card, fromListId, list.id, newIndex);
                         },
                         onRenameList: (currentTitle) => _showRenameListDialog(context, ref, list.id, currentTitle),
                     );

                 },
             ),
         ),
    );
  }

  void _showAddListDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text("Add List"),
        content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: "List Title", hintText: "To Do, Done..."),
            autofocus: true,
        ),
        actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
            FilledButton(onPressed: () {
                if (controller.text.isNotEmpty) {
                    ref.read(kanbanProvider.notifier).addList(controller.text);
                    Navigator.pop(ctx);
                }
            }, child: const Text("Create"))
        ],
    ));
  }

  void _showRenameListDialog(BuildContext context, WidgetRef ref, String listId, String currentTitle) {
      final controller = TextEditingController(text: currentTitle);
      showDialog(context: context, builder: (ctx) => AlertDialog(
          title: const Text("Rename List"),
          content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "List Title"),
              autofocus: true,
              onSubmitted: (_) {
                  if (controller.text.isNotEmpty) {
                      ref.read(kanbanProvider.notifier).renameList(listId, controller.text);
                      Navigator.pop(ctx);
                  }
              },
          ),
          actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
              FilledButton(onPressed: () {
                  if (controller.text.isNotEmpty) {
                      ref.read(kanbanProvider.notifier).renameList(listId, controller.text);
                      Navigator.pop(ctx);
                  }
              }, child: const Text("Save"))
          ],
      ));
  }

  void _showAddCardDialog(BuildContext context, WidgetRef ref, String listId) {
      showDialog(context: context, builder: (ctx) => CardDialog(
          onSave: (title, desc, image) {
              final newCardRef = ref.read(kanbanProvider.notifier);
              // We need to add card with all details. 
              // The notifier's addCard currently only takes title/desc.
              // I should update notifier to take optional image.
              // For now, I'll add then update, or changing the notifier.
              
              // Let's assume I update the notifier soon. 
              // Sending title and desc first.
              // Wait, image is important. I should update Notifier.
              
              // Hack for now: Concatenate? No.
              // I'll update the Notifier method signature in a subsequent step if needed,
              // or just update the card immediately after adding.
              // But `addCard` generates ID. I can't easily update immediately without knowing ID.
              
              // Better: Update KanbanNotifier to accept imageBase64 in addCard.
              // OR: Create the card object here and pass it.
              // Provider's addCard signature: void addCard(String listId, String title, String description)
              
              // I will use addCard, then find the card? No.
              // I will refactor addCard in the provider to take optional image.
              
              // BUT, I can't refactor provider right now without another tool call.
              // I'll proceed with creating it, and noting to refactor.
              
              newCardRef.addCard(listId, title, desc, imageBase64: image);
          }
      ));
  }

  void _showEditCardDialog(BuildContext context, WidgetRef ref, String listId, KanbanCard card) {
      showDialog(context: context, builder: (ctx) => CardDialog(
          title: card.title,
          description: card.description,
          existingImageBase64: card.imageBase64,
          onSave: (title, desc, image) {
              final updatedCard = card.copyWith(
                  title: title,
                  description: desc,
                  imageBase64: image
              );
              ref.read(kanbanProvider.notifier).updateCard(listId, updatedCard);
          }
      ));
  }

  void _showMoveCardDialog(BuildContext context, WidgetRef ref, String currentListId, KanbanCard card) {
       final state = ref.read(kanbanProvider);
       if (state.selectedWorkspaceId == null || state.selectedBoardId == null) return;
       
       showDialog(context: context, builder: (ctx) => MoveCardDialog(
           data: state.data,
           currentWorkspaceId: state.selectedWorkspaceId!,
           currentBoardId: state.selectedBoardId!,
           currentListId: currentListId,
           onMove: (wsId, boardId, listId) {
               // If moving within same board -> use moveCard logic (or refactor moveCard to support cross-board)
               // The current moveCard in Notifier only supports moving within the CURRENT board.
               // We need to implement cross-board move in Notifier.
               // Let's implement `moveCardCrossBoard` in Notifier.
               
               ref.read(kanbanProvider.notifier).moveCardCrossBoard(
                   card, 
                   state.selectedWorkspaceId!, 
                   state.selectedBoardId!, 
                   currentListId, 
                   wsId, 
                   boardId, 
                   listId
               );
           }
       ));
  }
  void _showRenameBoardDialog(BuildContext context, WidgetRef ref, String boardId, String currentTitle) {
      final controller = TextEditingController(text: currentTitle);
      showDialog(context: context, builder: (ctx) => AlertDialog(
          title: const Text("Rename Board"),
          content: TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Board Title"),
              autofocus: true,
              onSubmitted: (_) {
                  if (controller.text.isNotEmpty) {
                      ref.read(kanbanProvider.notifier).renameBoard(boardId, controller.text);
                      Navigator.pop(ctx);
                  }
              },
          ),
          actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
              FilledButton(onPressed: () {
                  if (controller.text.isNotEmpty) {
                      ref.read(kanbanProvider.notifier).renameBoard(boardId, controller.text);
                      Navigator.pop(ctx);
                  }
              }, child: const Text("Save"))
          ],
      ));
  }
}
