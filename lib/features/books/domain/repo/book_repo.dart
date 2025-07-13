import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../books/domain/entity/reaction_entity.dart';
import '../entity/book_response_entity.dart';
import '../entity/book_details_entity.dart';

abstract class BookRepo {
  Future<Either<Failure, BookResponseEntity>> getBooks();
  Future<Either<Failure, BookDetailsEntity>> getBookDetails(int bookId);
  Future<Either<Failure, ReactionEntity>> toggleReaction(String id);

}