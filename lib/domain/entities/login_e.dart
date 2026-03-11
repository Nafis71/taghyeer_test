/// Represents user login information and authentication tokens.
///
/// This class encapsulates user profile data and authentication tokens
/// returned after a successful login operation. It serves as the core
/// business entity for user authentication, independent of any external
/// data sources or frameworks.
///
/// All properties are nullable to handle cases where API responses
/// may not include all fields.
///
/// Security Note:
/// - Access tokens should be stored securely
/// - Refresh tokens are used to obtain new access tokens
/// - User information is stored separately from tokens
///
/// Example:
/// ```dart
/// final loginEntity = LoginEntity(
///   id: 1,
///   userName: "johndoe",
///   email: "john@example.com",
///   accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
/// );
/// ```
class LoginEntity {
  /// Unique user identifier.
  int? id;

  /// User's username or handle.
  String? userName;

  /// User's first name.
  String? firstName;

  /// User's last name.
  String? lastName;

  /// User's gender.
  String? gender;

  /// User's email address.
  String? email;

  /// URL to user's profile image.
  String? image;

  /// JWT access token for authenticated API requests.
  ///
  /// This token is used to authenticate subsequent API calls.
  /// Typically expires after a set period (e.g., 30 minutes).
  String? accessToken;

  /// Refresh token for obtaining new access tokens.
  ///
  /// Used to refresh expired access tokens without requiring
  /// the user to log in again.
  String? refreshToken;

  /// Creates a new [LoginEntity] instance.
  ///
  /// All parameters are optional and nullable.
  ///
  /// Parameters:
  /// - [id]: Unique user identifier
  /// - [userName]: Username
  /// - [firstName]: First name
  /// - [lastName]: Last name
  /// - [gender]: Gender
  /// - [email]: Email address
  /// - [image]: Profile image URL
  /// - [accessToken]: JWT access token
  /// - [refreshToken]: Refresh token
  LoginEntity({
    this.userName,
    this.firstName,
    this.lastName,
    this.gender,
    this.email,
    this.image,
    this.accessToken,
    this.refreshToken,
    this.id,
  });

  /// Creates a copy of this [LoginEntity] with the given fields replaced.
  ///
  /// Returns a new [LoginEntity] instance with updated values.
  /// Fields not provided will retain their original values.
  ///
  /// Parameters:
  /// - [userName]: Optional new username value
  /// - [firstName]: Optional new first name value
  /// - [lastName]: Optional new last name value
  /// - [gender]: Optional new gender value
  /// - [email]: Optional new email value
  /// - [image]: Optional new image URL value
  /// - [accessToken]: Optional new access token value
  /// - [refreshToken]: Optional new refresh token value
  /// - [id]: Optional new ID value
  ///
  /// Returns:
  /// - A new [LoginEntity] with updated values
  ///
  /// Example:
  /// ```dart
  /// final updatedEntity = loginEntity.copyWith(
  ///   accessToken: newToken,
  /// );
  /// ```
  LoginEntity copyWith({
    String? userName,
    String? firstName,
    String? lastName,
    String? gender,
    String? email,
    String? image,
    String? accessToken,
    String? refreshToken,
    int? id,
  }) {
    return LoginEntity(
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      image: image ?? this.image,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
    );
  }

  /// Returns a string representation of this [LoginEntity].
  ///
  /// Useful for debugging and logging purposes.
  ///
  /// Security Note:
  /// - Tokens are included in the string representation
  /// - Use with caution in logs to avoid token exposure
  ///
  /// Returns:
  /// - A string containing all login entity properties
  @override
  String toString() {
    return 'LoginEntity{userName: $userName, firstName: $firstName, lastName: $lastName, gender: $gender, email: $email, image: $image, accessToken: $accessToken, refreshToken: $refreshToken, id: $id}';
  }
}
