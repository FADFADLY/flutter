import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/book_data_entity.dart';
import '../../../domain/repo/book_repo.dart';



part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepo bookRepo;

  BookCubit({required this.bookRepo}) : super(BookInitial());

  Future<void> getBooks() async {
    emit(BookLoading());

    final books = await bookRepo.getBooks();
    books.fold(
      (failure) => emit(BookError(message: failure.message)),
      (response) {
        print(response.data);
        emit(BookLoaded(books: response.data));
      },
    );
  }
}