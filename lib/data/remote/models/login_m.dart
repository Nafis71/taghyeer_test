/// Data model for login API responses.
///
/// Extends [LoginEntity] and provides JSON serialization/deserialization
/// for API communication. This model handles the transformation between
/// API JSON format and domain entities.
import 'package:taghyeer_test/domain/entities/login_e.dart';

class LoginModel extends LoginEntity {
  LoginModel({
    super.userName,
    super.firstName,
    super.lastName,
    super.gender,
    super.email,
    super.image,
    super.accessToken,
    super.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      email: json['email'],
      image: json['image'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'email': email,
      'image': image,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
