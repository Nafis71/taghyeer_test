class LoginEntity {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? image;
  String? accessToken;
  String? refreshToken;

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

  @override
  String toString() {
    return 'LoginEntity{userName: $userName, firstName: $firstName, lastName: $lastName, gender: $gender, email: $email, image: $image, accessToken: $accessToken, refreshToken: $refreshToken, id: $id}';
  }
}
