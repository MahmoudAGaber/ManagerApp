
class UserModel {
  final int id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String token;
  final String refreshToken;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}