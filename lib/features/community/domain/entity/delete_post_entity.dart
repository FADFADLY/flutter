import 'package:meta/meta.dart';

@immutable
abstract class DeletePostEntity {
  final bool success;
  final String message;
  final dynamic data;
  final int code;

  const DeletePostEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.code,
  });
}