abstract class ProfileDataEntity {
  final String name;
  final String email;
  final String? avatar;
  final String? bio;
  final String gender;
  final String age;
  final String? username;

  const ProfileDataEntity( {required this.username,
    required this.name,
    required this.email,
    this.avatar,
    this.bio,
    required this.gender,
    required this.age,
  });
}