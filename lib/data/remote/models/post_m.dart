/// Data model for post API responses.
///
/// Extends [PostEntity] and provides JSON serialization/deserialization
/// for API communication. This model handles the transformation between
/// API JSON format and domain entities.
import 'package:taghyeer_test/data/remote/models/reaction_m.dart';
import 'package:taghyeer_test/domain/entities/post_e.dart';

class PostModel extends PostEntity {
  PostModel({
    super.body,
    super.id,
    super.reactions,
    super.tags,
    super.title,
    super.views,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    body: json["body"],
    id: json["id"],
    reactions: ReactionModel.fromJson(json['reactions']),
    tags: json["tags"] != null ? List.from((json["tags"] as List).map((tag) => tag.toString())) : [],
    title: json["title"],
    views: json["views"],
  );
}
