import 'package:flutter/material.dart';
import '../../models/app_data.dart';
import '../../models/workspace.dart';
import '../../models/kanban_board.dart';
import '../../models/kanban_list.dart';

class MoveCardDialog extends StatefulWidget {
  final AppData data;
  final String currentWorkspaceId;
  final String currentBoardId;
  final String currentListId;
  final Function(String wsId, String boardId, String listId) onMove;

  const MoveCardDialog({
    super.key,
    required this.data,
    required this.currentWorkspaceId,
    required this.currentBoardId,
    required this.currentListId,
    required this.onMove,
  });

  @override
  State<MoveCardDialog> createState() => _MoveCardDialogState();
}

class _MoveCardDialogState extends State<MoveCardDialog> {
  String? _selectedWorkspaceId;
  String? _selectedBoardId;
  String? _selectedListId;

  @override
  void initState() {
    super.initState();
    _selectedWorkspaceId = widget.currentWorkspaceId;
    _selectedBoardId = widget.currentBoardId;
    _selectedListId = widget.currentListId;
  }

  List<Workspace> get _workspaces => widget.data.workspaces;
  
  List<KanbanBoard> get _boards {
    if (_selectedWorkspaceId == null) return [];
    final ws = widget.data.workspaces
        .firstWhere((w) => w.id == _selectedWorkspaceId, orElse: () => widget.data.workspaces.first);
    return ws.boards;
  }

  List<KanbanList> get _lists {
      if (_selectedBoardId == null) return [];
      final board = _boards.firstWhere((b) => b.id == _selectedBoardId, orElse: () => _boards.first);
      return board.lists;      
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Move Card to..."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Workspace Selector
          DropdownButtonFormField<String>(
            initialValue: _selectedWorkspaceId,
            decoration: const InputDecoration(labelText: "Workspace"),
            items: _workspaces.map((ws) => DropdownMenuItem(value: ws.id, child: Text(ws.title))).toList(),
            onChanged: (val) {
              setState(() {
                _selectedWorkspaceId = val;
                final ws = widget.data.workspaces.firstWhere((w) => w.id == val);
                _selectedBoardId = ws.boards.isNotEmpty ? ws.boards.first.id : null;
                // auto-select list if board has lists
                 if (_selectedBoardId != null) {
                    final b = ws.boards.firstWhere((b) => b.id == _selectedBoardId);
                    _selectedListId = b.lists.isNotEmpty ? b.lists.first.id : null;
                 } else {
                    _selectedListId = null;
                 }
              });
            },
          ),
          const SizedBox(height: 16),
          // Board Selector
          DropdownButtonFormField<String>(
            initialValue: _selectedBoardId,
            decoration: const InputDecoration(labelText: "Board"),
            items: _boards.isEmpty ? [] : _boards.map((b) => DropdownMenuItem(value: b.id, child: Text(b.title))).toList(),
            onChanged: (val) {
               setState(() {
                  _selectedBoardId = val;
                   if (val != null) {
                      final b = _boards.firstWhere((b) => b.id == val);
                      _selectedListId = b.lists.isNotEmpty ? b.lists.first.id : null;
                   } else {
                        _selectedListId = null;
                   }
               });
            },
          ),
           const SizedBox(height: 16),
          // List Selector
          DropdownButtonFormField<String>(
            initialValue: _selectedListId,
            decoration: const InputDecoration(labelText: "List"),
            items: _lists.isEmpty ? [] : _lists.map((l) => DropdownMenuItem(value: l.id, child: Text(l.title))).toList(),
            onChanged: (val) {
               setState(() {
                  _selectedListId = val;
               });
            },
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        FilledButton(
          onPressed: (_selectedWorkspaceId != null && _selectedBoardId != null && _selectedListId != null) 
              ? () {
                  widget.onMove(_selectedWorkspaceId!, _selectedBoardId!, _selectedListId!);
                  Navigator.pop(context);
                }
              : null,
          child: const Text("Move"),
        )
      ],
    );
  }
}
