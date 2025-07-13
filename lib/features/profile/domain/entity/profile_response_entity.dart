import 'package:graduationproject/features/profile/domain/entity/profile_data_entity.dart';

abstract class ProfileResponseEntity {
  final bool success;
  final String message;
  final ProfileDataEntity data;
  final dynamic errors;
  final int code;

  const ProfileResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.code,
  });
}