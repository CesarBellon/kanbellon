import 'package:flutter/material.dart';
import '../../models/kanban_list.dart';
import '../../models/kanban_card.dart';
import 'kanban_card_widget.dart';
import 'drag_data.dart';

class KanbanListWidget extends StatelessWidget {
  final KanbanList list;
  final Function(KanbanCard, String, int) onCardReceived; // card, fromListId, newIndex
  final Function(KanbanCard) onCardTap;
  final VoidCallback onAddCard;
  final Function(String) onDeleteList;
  final Function(KanbanCard) onDeleteCard;
  final Function(KanbanCard) onRequestMove;
  final Function(String) onRenameList;


  const KanbanListWidget({
    super.key,
    required this.list,
    required this.onCardReceived,
    required this.onCardTap,
    required this.onAddCard,
    required this.onDeleteList,
    required this.onDeleteCard,
    required this.onRequestMove,
    required this.onRenameList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color?.withOpacity(0.5) ?? Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () => onRenameList(list.title),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            child: Text(list.title, style: Theme.of(context).textTheme.titleMedium),
                        ),
                    ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                     // Delete list option
                     showModalBottomSheet(context: context, builder: (ctx) => Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                             ListTile(
                                 leading: const Icon(Icons.delete),
                                 title: const Text("Delete List"),
                                 onTap: () {
                                     Navigator.pop(ctx);
                                     onDeleteList(list.id);
                                 },
                             ),
                             ListTile(
                                 leading: const Icon(Icons.edit),
                                 title: const Text("Rename List"),
                                 onTap: () {
                                     Navigator.pop(ctx);
                                     onRenameList(list.title);
                                 },
                             )
                         ],
                     ));
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Theme.of(context).dividerColor.withOpacity(0.2)),
          
          // List Cards
          Expanded(
            child: DragTarget<CardDragData>(
              onWillAcceptWithDetails: (data) => true,
              onAcceptWithDetails: (dragData) {
                 if (dragData.data.fromListId == list.id) return; // Dropping on same list, usually reorder, handled by inner targets? logic tricky
                 // Appending to end
                 onCardReceived(dragData.data.card, dragData.data.fromListId, list.cards.length); 
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: list.cards.length,
                  itemBuilder: (context, index) {
                    final card = list.cards[index];
                    return DragTarget<CardDragData>(
                        // Nested drag target for reordering
                        onWillAcceptWithDetails: (data) => data.data.card.id != card.id,
                        onAcceptWithDetails: (droppedData) {
                            onCardReceived(droppedData.data.card, droppedData.data.fromListId, index);
                        },
                        builder: (ctx, candidates, _) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    if (candidates.isNotEmpty)
                                        Container(height: 4, margin: EdgeInsets.symmetric(vertical: 4), color: Colors.blueAccent),
                                    KanbanCardWidget(
                                        card: card,
                                        listId: list.id,
                                        onTap: onCardTap,
                                        onDelete: onDeleteCard,
                                        onRequestMove: onRequestMove,
                                    ),
                                ],
                            );
                        }
                    );
                  },
                );
              },
            ),
          ),
          
          // Add Card Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              onPressed: onAddCard,
              icon: const Icon(Icons.add),
              label: const Text("Add Card"),
              style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  alignment: Alignment.centerLeft
              ),
            ),
          )
        ],
      ),
    );
  }
}
