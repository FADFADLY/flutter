import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repo/repo.dart';

part 'store_post_state.dart';

class StorePostCubit extends Cubit<StorePostState> {
  StorePostCubit({required this.postsRepo}) : super(StorePostInitial());
  final PostsRepo postsRepo;

  Future<void> storePost({required String content}) async {
    emit(StorePostLoading());
    final result = await postsRepo.storePost(content: content);
    result.fold(
      (failure) {
        print("Failure: $failure");
        emit(StorePostError(message: failure.message));
      },
      (response) {
        print("Response: $response");
        print("Message: ${response.message}");
        emit(StorePostSuccess(message: response.message));
      },
    );
  }
  Future<void> storePostWithImage({required String content , required File image}) async {
    emit(StorePostLoading());
    final result = await postsRepo.storePostWithImage(content: content , image: image);
    result.fold(
      (failure) {
        print("Failure: $failure");
        emit(StorePostError(message: failure.message));
      },
      (response) {
        print("Response: $response");
        print("Message: ${response.message}");
        emit(StorePostSuccess(message: response.message));
      },
    );
  }
  Future<void> storePostWithFile({required String content , required File file}) async {
    emit(StorePostLoading());
    final result = await postsRepo.storePostWithFile(content: content , file: file);
    result.fold(
      (failure) {
        print("Failure: $failure");
        emit(StorePostError(message: failure.message));
      },
      (response) {
        print("Response: $response");
        print("Message: ${response.message}");
        emit(StorePostSuccess(message: response.message));
      },
    );
  }
  Future<void> storePostWithAudio({required String content , required File audio}) async {
    emit(StorePostLoading());
    final result = await postsRepo.storePostWithFile(content: content , file: audio);
    result.fold(
      (failure) {
        print("Failure: $failure");
        emit(StorePostError(message: failure.message));
      },
      (response) {
        print("Response: $response");
        print("Message: ${response.message}");
        emit(StorePostSuccess(message: response.message));
      },
    );
  }
  Future<void> storePostWithPoll({required List<String> options , required String content }) async {
    emit(StorePostLoading());
    final result = await postsRepo.storePostWithPoll( options: options , content: content,);
    result.fold(
      (failure) {
        print("Failure: $failure");
        emit(StorePostError(message: failure.message));
      },
      (response) {
        print("Response: $response");
        print("Message: ${response.message}");
        emit(StorePostSuccess(message: response.message));
      },
    );
  }



}
