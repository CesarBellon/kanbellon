import '../../models/kanban_card.dart';

class CardDragData {
  final KanbanCard card;
  final String fromListId;

  CardDragData({required this.card, required this.fromListId});
}
