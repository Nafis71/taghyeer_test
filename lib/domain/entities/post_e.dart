/// Represents a post entity in the domain layer.
///
/// This class encapsulates all post-related data and business logic.
/// It serves as the core business entity for posts, independent of
/// any external data sources or frameworks.
///
/// All properties are nullable to handle cases where API responses
/// may not include all fields.
///
/// Example:
/// ```dart
/// final post = PostEntity(
///   id: 1,
///   title: "Sample Post",
///   body: "Post content",
///   views: 100,
/// );
/// ```
import 'package:taghyeer_test/domain/entities/reaction_e.dart';

class PostEntity {
  /// Unique identifier for the post.
  int? id;

  /// Post title or headline.
  String? title;

  /// Post body content or description.
  String? body;

  /// List of tags associated with the post.
  ///
  /// Used for categorization and search functionality.
  List<String>? tags;

  /// Number of times the post has been viewed.
  int? views;

  /// User reactions to the post (likes and dislikes).
  ///
  /// Contains aggregated reaction counts from users.
  ReactionEntity? reactions;

  /// Creates a new [PostEntity] instance.
  ///
  /// All parameters are optional and nullable.
  ///
  /// Parameters:
  /// - [id]: Unique post identifier
  /// - [title]: Post title
  /// - [body]: Post content
  /// - [tags]: List of post tags
  /// - [views]: View count
  /// - [reactions]: Post reactions
  PostEntity({
    this.id,
    this.title,
    this.body,
    this.tags,
    this.views,
    this.reactions,
  });

  /// Creates a copy of this [PostEntity] with the given fields replaced.
  ///
  /// Returns a new [PostEntity] instance with updated values.
  /// Fields not provided will retain their original values.
  ///
  /// Parameters:
  /// - [id]: Optional new ID value
  /// - [title]: Optional new title value
  /// - [body]: Optional new body value
  /// - [tags]: Optional new tags list
  /// - [views]: Optional new views count
  /// - [reactions]: Optional new reactions entity
  ///
  /// Returns:
  /// - A new [PostEntity] with updated values
  ///
  /// Example:
  /// ```dart
  /// final updatedPost = post.copyWith(views: post.views! + 1);
  /// ```
  PostEntity copyWith({
    int? id,
    String? title,
    String? body,
    List<String>? tags,
    int? views,
    ReactionEntity? reactions,
  }) {
    return PostEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      tags: tags ?? this.tags,
      views: views ?? this.views,
      reactions: reactions ?? this.reactions,
    );
  }

  /// Returns a string representation of this [PostEntity].
  ///
  /// Useful for debugging and logging purposes.
  ///
  /// Returns:
  /// - A string containing all post properties
  @override
  String toString() {
    return 'PostEntity{id: $id, title: $title, body: $body, tags: $tags, views: $views, reactions: $reactions}';
  }
}