import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../books/domain/entity/book_data_entity.dart';
import '../../../../books/domain/repo/book_repo.dart';
import '../../../domain/repo/repo.dart';




part 'liked_book_state.dart';

class LikedBookCubit extends Cubit<BookLikedState> {
  final ProfileRepo profileRepo;

  LikedBookCubit({required this.profileRepo}) : super(BookLikedInitial());

  Future<void> getLikedBooks() async {
    emit(BookLikedLoading());

    final books = await profileRepo.getLikedBooks();
    books.fold(
      (failure) => emit(BookLikedError(message: failure.message)),
      (response) {
        print(response.data);
        emit(BookLikedLoaded(books: response.data));
      },
    );
  }
}