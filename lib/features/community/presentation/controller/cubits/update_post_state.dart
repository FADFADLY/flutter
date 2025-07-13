part of 'update_post_cubit.dart';

abstract class UpdatePostState {
  const UpdatePostState();
}

class UpdatePostInitial extends UpdatePostState {}

class UpdatePostLoading extends UpdatePostState {
  final int postId;

  const UpdatePostLoading({required this.postId});
}

class UpdatePostLoaded extends UpdatePostState {
  final UpdatePostEntity response;
  final int postId;

  const UpdatePostLoaded({required this.response, required this.postId});
}

class UpdatePostError extends UpdatePostState {
  final String message;
  final int postId;

  const UpdatePostError({required this.message, required this.postId});
}