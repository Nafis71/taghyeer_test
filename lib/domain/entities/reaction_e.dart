/// Represents user reactions (likes and dislikes) for a post.
///
/// This class encapsulates reaction counts for posts. It serves as the core
/// business entity for post reactions, independent of any external data sources
/// or frameworks.
///
/// All properties are nullable to handle cases where API responses
/// may not include all fields.
///
/// Example:
/// ```dart
/// final reactions = ReactionEntity(
///   likes: 42,
///   dislikes: 3,
/// );
/// ```
class ReactionEntity {
  /// Number of likes received.
  ///
  /// Represents the count of positive reactions from users.
  int? likes;

  /// Number of dislikes received.
  ///
  /// Represents the count of negative reactions from users.
  int? dislikes;

  /// Creates a new [ReactionEntity] instance.
  ///
  /// All parameters are optional and nullable.
  ///
  /// Parameters:
  /// - [likes]: Number of likes
  /// - [dislikes]: Number of dislikes
  ReactionEntity({
    this.likes,
    this.dislikes,
  });

  /// Creates a copy of this [ReactionEntity] with the given fields replaced.
  ///
  /// Returns a new [ReactionEntity] instance with updated values.
  /// Fields not provided will retain their original values.
  ///
  /// Parameters:
  /// - [likes]: Optional new likes count
  /// - [dislikes]: Optional new dislikes count
  ///
  /// Returns:
  /// - A new [ReactionEntity] with updated values
  ///
  /// Example:
  /// ```dart
  /// final updatedReactions = reactions.copyWith(
  ///   likes: reactions.likes! + 1,
  /// );
  /// ```
  ReactionEntity copyWith({
    int? likes,
    int? dislikes,
  }) {
    return ReactionEntity(
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
    );
  }

  /// Returns a string representation of this [ReactionEntity].
  ///
  /// Useful for debugging and logging purposes.
  ///
  /// Returns:
  /// - A string containing reaction counts
  @override
  String toString() {
    return 'ReactionEntity{likes: $likes, dislikes: $dislikes}';
  }
}