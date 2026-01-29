import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanban_card.freezed.dart';
part 'kanban_card.g.dart';

@freezed
abstract class KanbanCard with _$KanbanCard {
  const factory KanbanCard({
    required String id,
    required String title,
    @Default('') String description,
    
    // Base64 encoded image string. 
    // In a real app, this would likely be a file path or URL.
    @JsonKey(name: 'image_base64') String? imageBase64, 
  }) = _KanbanCard;

  factory KanbanCard.fromJson(Map<String, dynamic> json) => 
      _$KanbanCardFromJson(json);
}
