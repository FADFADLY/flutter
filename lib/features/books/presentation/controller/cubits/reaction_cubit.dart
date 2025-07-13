import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../books/domain/entity/reaction_entity.dart';
import '../../../domain/repo/book_repo.dart';



part 'reaction_state.dart';

class BooksReactionCubit extends Cubit<BooksReactionState> {
  final BookRepo bookRepo;

  BooksReactionCubit({required this.bookRepo}) : super(BooksReactionInitial());

  Future<void> toggleReaction(String id) async {
    emit(BooksReactionLoading());

    final reaction = await bookRepo.toggleReaction(id);
    reaction.fold(
          (failure) => emit(BooksReactionError(message: failure.message)),
          (response) {
        print(response.message);
        emit(BooksReactionLoaded(response: response));
      },
    );
  }
}