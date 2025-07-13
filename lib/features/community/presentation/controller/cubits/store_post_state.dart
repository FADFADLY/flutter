part of 'store_post_cubit.dart';

@immutable
sealed class StorePostState {}

final class StorePostInitial extends StorePostState {}

final class StorePostLoading extends StorePostState {}

final class StorePostError extends StorePostState {
  final String message;
  StorePostError({required this.message});
}

final class StorePostSuccess extends StorePostState {
  final String message;
  StorePostSuccess({required this.message});
}
