part of 'delete_post_cubit.dart';

@immutable
abstract class DeletePostState {}

class DeletePostInitial extends DeletePostState {}

class DeletePostLoading extends DeletePostState {
  final int postId;

  DeletePostLoading({required this.postId});
}

class DeletePostLoaded extends DeletePostState {
  final String message;
  final int postId;

  DeletePostLoaded({required this.message, required this.postId});
}

class DeletePostError extends DeletePostState {
  final String message;
  final int postId;

  DeletePostError({required this.message, required this.postId});
}