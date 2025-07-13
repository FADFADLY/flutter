part of 'liked_items_cubit.dart';

@immutable
sealed class LikedItemsState {}

final class LikedItemsInitial extends LikedItemsState {}

final class LikedItemsLoading extends LikedItemsState {}

final class LikedItemsLoaded extends LikedItemsState {
  final LikedItemsResponseEntity likedItems;

  LikedItemsLoaded({required this.likedItems});
}

final class LikedItemsError extends LikedItemsState {
  final String message;

  LikedItemsError({required this.message});
}