import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/kanban_provider.dart';
import '../../models/workspace.dart';
import 'board_view.dart';
import 'package:file_selector/file_selector.dart';
import '../widgets/settings_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSidebarOpen = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final kanbanState = ref.watch(kanbanProvider);
    final kanbanNotifier = ref.read(kanbanProvider.notifier);

    if (kanbanState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    if (kanbanState.error != null) {
      return Scaffold(body: Center(child: Text('Error: ${kanbanState.error}')));
    }

    // Check configuration (Desktop only usually)
    if (!kanbanState.isConfigured) {
        return Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text("Welcome to Kanban!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        const Text("Please select a location to save your data."),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                            onPressed: () async {
                                String? selectedDirectory = await getDirectoryPath();
                                if (selectedDirectory == null) return;
                                // Create file path
                                final path = '$selectedDirectory/kanban_data.json';
                                ref.read(kanbanProvider.notifier).setPersistencePath(path);
                            },
                            icon: const Icon(Icons.folder_open),
                            label: const Text("Select Data Folder")
                        )
                    ],
                ),
            ),
        );
    }

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSidebarOpen ? 250 : 0,
            child: ClipRect(
              child: OverflowBox(
              minWidth: 250,
              maxWidth: 250,
              child: Container(
                color: Theme.of(context).cardTheme.color,
                child: Column(
                  children: [
                     const SizedBox(height: 16),
                     // Title / App Name
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Row(
                         children: [
                           Image.asset('assets/icon.png', height: 28, width: 28),
                           const SizedBox(width: 8),
                           Text('Kanbellon', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                         ],
                       ),
                     ),
                     const Divider(height: 32),
                     
                     // Workspaces List
                     Expanded(
                       child: ListView.builder(
                         itemCount: kanbanState.data.workspaces.length,
                         itemBuilder: (context, index) {
                           final ws = kanbanState.data.workspaces[index];
                           return _WorkspaceItem(
                              workspace: ws,
                              isSelected: kanbanState.selectedWorkspaceId == ws.id,
                              selectedBoardId: kanbanState.selectedBoardId,
                              onWorkspaceTap: () => kanbanNotifier.selectWorkspace(ws.id),
                              onBoardTap: (boardId) => kanbanNotifier.selectBoard(boardId),
                              onAddBoard: () => _showAddBoardDialog(context),
                              onDeleteBoard: (id) => kanbanNotifier.deleteBoard(id),
                              onDeleteWorkspace: () => kanbanNotifier.deleteWorkspace(ws.id),
                           );
                         },
                       ),
                     ),
                     
                     // Add Workspace Button
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ElevatedButton.icon(
                         onPressed: () => _showAddWorkspaceDialog(context),
                         icon: const Icon(Icons.add),
                         label: const Text('New Workspace'),
                         style: ElevatedButton.styleFrom(
                           minimumSize: const Size(double.infinity, 48),
                         ),
                       ),
                     ),
                     // Settings Button
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Tooltip(
                           message: "Settings", 
                           child: IconButton(
                              onPressed: () => showDialog(context: context, builder: (c) => const SettingsDialog()), 
                              icon: const Icon(Icons.settings)
                           )
                       ),
                     ),
                  ],
                ),
              ),
            ),
          ),
          ),
          
          // Main Content
          Expanded(
            child: kanbanState.selectedWorkspaceId == null
                ? const Center(child: Text("Select a workspace"))
                : kanbanState.selectedBoardId == null 
                    ? const Center(child: Text("Select a board"))
                    : BoardView(
                        boardId: kanbanState.selectedBoardId!,
                        onToggleSidebar: _toggleSidebar,
                        isSidebarOpen: _isSidebarOpen,
                      ),
          ),
        ],
      ),
    );
  }

  void _showAddWorkspaceDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('New Workspace'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: 'Display Name', hintText: 'Personal, Work...'),
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () {
          if (controller.text.isNotEmpty) {
            ref.read(kanbanProvider.notifier).addWorkspace(controller.text);
            Navigator.pop(ctx);
          }
        }, child: const Text('Create')),
      ],
    ));
  }

  void _showAddBoardDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('New Board'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(labelText: 'Board Title', hintText: 'Roadmap, Q1 Goals...'),
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () {
          if (controller.text.isNotEmpty) {
            ref.read(kanbanProvider.notifier).addBoard(controller.text);
            Navigator.pop(ctx);
          }
        }, child: const Text('Create')),
      ],
    ));
  }
}

class _WorkspaceItem extends StatelessWidget {
  final Workspace workspace;
  final bool isSelected;
  final String? selectedBoardId;
  final VoidCallback onWorkspaceTap;
  final Function(String) onBoardTap;
  final VoidCallback onAddBoard;
  final Function(String) onDeleteBoard;
  final VoidCallback onDeleteWorkspace;

  const _WorkspaceItem({
    required this.workspace,
    required this.isSelected,
    required this.selectedBoardId,
    required this.onWorkspaceTap,
    required this.onBoardTap,
    required this.onAddBoard,
    required this.onDeleteBoard,
    required this.onDeleteWorkspace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onWorkspaceTap,
          child: Container(
            color: isSelected ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2) : null,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(child: Text(workspace.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
                if (isSelected) 
                  IconButton(onPressed: onDeleteWorkspace, icon: const Icon(Icons.delete, size: 16, color: Colors.white30), tooltip: "Delete Workspace",),
                
              ],
            ),
          ),
        ),
        if (isSelected)
          Column(
              children: [
                  ...workspace.boards.map((board) => InkWell(
                      onTap: () => onBoardTap(board.id),
                      child: Container(
                          padding: const EdgeInsets.only(left: 32, right: 16, top: 8, bottom: 8),
                          color: selectedBoardId == board.id ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3) : null,
                          child: Row(
                              children: [
                                  const Icon(Icons.table_chart, size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(board.title, style: const TextStyle(fontSize: 14))),
                                  if(selectedBoardId == board.id)
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(Icons.close, size: 14), 
                                        onPressed: () => onDeleteBoard(board.id)
                                    )
                              ],
                          ),
                      ),
                  )),
                  InkWell(
                      onTap: onAddBoard,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32, top: 8, bottom: 8),
                        child: Row(
                            children: const [
                                Icon(Icons.add, size: 16, color: Colors.grey),
                                SizedBox(width: 8),
                                Text('Add Board', style: TextStyle(color: Colors.grey))
                            ],
                        ),
                      )
                  )
              ],
          )
      ],
    );
  }
}
