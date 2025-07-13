
import '../../domain/entity/profile_data_entity.dart';

class ProfileModel extends ProfileDataEntity {
  const ProfileModel({
    required String name,
    required String email,
    String? avatar,
    String? bio,
    required String gender,
    required String age,
    required String username,
  }) : super(
    username: username,
          name: name,
          email: email,
          avatar: avatar,
          bio: bio,
          gender: gender,
          age: age,
        );

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      bio: json['bio'],
      gender: json['gender'] ?? '',
      age: json['age'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'avatar': avatar,
        'bio': bio,
        'gender': gender,
        'age': age,
      };
}