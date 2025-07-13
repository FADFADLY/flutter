import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/book_details_data_entity.dart';
import '../../../domain/repo/book_repo.dart';
part 'book_details_state.dart';



class BookDetailsCubit extends Cubit<BookDetailsState> {
  final BookRepo bookRepo;

  BookDetailsCubit({required this.bookRepo}) : super(BookDetailsInitial());

  Future<void> getBookDetails(int bookId) async {
    emit(BookDetailsLoading());

    final details = await bookRepo.getBookDetails(bookId);
    details.fold(
      (failure) => emit(BookDetailsError(message: failure.message)),
      (response) {
        print(response.data);
        emit(BookDetailsLoaded(details: response.data));
      },
    );
  }
}