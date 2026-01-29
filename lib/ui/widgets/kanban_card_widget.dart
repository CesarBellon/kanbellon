import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/kanban_card.dart';
import 'drag_data.dart';

class KanbanCardWidget extends StatelessWidget {
  final KanbanCard card;
  final String listId;
  final Function(KanbanCard) onTap;
  final Function(KanbanCard) onDelete;
  final Function(KanbanCard) onRequestMove;

  const KanbanCardWidget({
    super.key,
    required this.card,
    required this.listId,
    required this.onTap,
    required this.onDelete,
    required this.onRequestMove,
  });

  @override
  Widget build(BuildContext context) {
    // Draggable wrapper
    return Draggable<CardDragData>(
      data: CardDragData(card: card, fromListId: listId),
      feedback: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 280,
          child: _CardContent(card: card, onMenuPressed: (_) {}), // No menu in feedback
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _CardContent(card: card, onMenuPressed: (_) {}), // No menu in drag placeholder
      ),
      child: GestureDetector(
        onTap: () => onTap(card),
        child: _CardContent(
            card: card, 
            onMenuPressed: (context) {
                // Approximate position for the icon button menu
                final renderBox = context.findRenderObject() as RenderBox;
                final offset = renderBox.localToGlobal(Offset.zero);
                final size = renderBox.size;
                final overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
                
                _showCardMenu(
                    context,
                    RelativeRect.fromRect(
                        offset & size,
                        Offset.zero & overlay.size
                    )
                );
            }
        ),
      ),
    );
  }

  void _showCardMenu(BuildContext context, RelativeRect position) {
      showMenu(
        context: context,
        position: position,
        items: [
            PopupMenuItem(
                child: const Text("Move to..."),
                onTap: () => onRequestMove(card),
            ),
             PopupMenuItem(
                child: const Text("Delete"),
                onTap: () => onDelete(card),
            ),
        ]
    );
  }
}

class _CardContent extends StatelessWidget {
  final KanbanCard card;
  final Function(BuildContext) onMenuPressed;
  
  const _CardContent({required this.card, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (card.imageBase64 != null && card.imageBase64!.isNotEmpty)
                Image.memory(
                  base64Decode(card.imageBase64!),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 40, 12), // Extra right padding for icon
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (card.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        card.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ]
                  ],
                ),
              )
            ],
          ),
          Positioned(
             right: 4,
             top: 4,
             child: Builder(
               builder: (ctx) => IconButton(
                 icon: const Icon(Icons.more_vert, size: 20),
                 onPressed: () => onMenuPressed(ctx),
               ),
             ),
          )
        ],
      ),
    );
  }
}
