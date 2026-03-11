/// Data model for reaction API responses.
///
/// Extends [ReactionEntity] and provides JSON serialization/deserialization
/// for API communication. This model handles the transformation between
/// API JSON format and domain entities.
import 'package:taghyeer_test/domain/entities/reaction_e.dart';

class ReactionModel extends ReactionEntity {
  ReactionModel({super.dislikes, super.likes});

  factory ReactionModel.fromJson(Map<String, dynamic> json) =>
      ReactionModel(dislikes: json["dislikes"], likes: json["likes"]);
}
