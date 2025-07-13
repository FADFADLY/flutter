import 'package:dartz/dartz.dart';
import 'package:graduationproject/features/books/domain/entity/reaction_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/remote/book_service.dart';
import '../../domain/entity/book_response_entity.dart';
import '../../domain/entity/book_details_entity.dart';
import '../../domain/repo/book_repo.dart';

class BookRepoImpl extends BookRepo {
  final BookService bookService;

  BookRepoImpl({required this.bookService});

  @override
  Future<Either<Failure, BookResponseEntity>> getBooks() async {
    try {
      final response = await bookService.getAllBooks();
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
            message: response.message, statusCode: response.code));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getBooks: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
          message: "Failed to process books data: ${e.toString()}"));
    }
  }
  Future<Either<Failure, ReactionEntity>> toggleReaction(String id) async {
    try {
      final response = await bookService.toggleReaction(id);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in toggleReaction: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to toggle reaction: ${e.toString()}",
      ));
    }
  }

  @override
  Future<Either<Failure, BookDetailsEntity>> getBookDetails(int bookId) async {
    try {
      final response = await bookService.getBookDetails(bookId);
      if (response.success) {
        return Right(response);
      } else {
        return Left(ServerFailure(
          message: response.message,
          statusCode: response.code,
        ));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on InvalidResponseException catch (e) {
      return Left(InvalidResponseFailure(message: e.message));
    } catch (e, stackTrace) {
      print("Error in getBookDetails: $e");
      print("Stack trace: $stackTrace");
      return Left(GenericFailure(
        message: "Failed to process book details: ${e.toString()}",
      ));
    }
  }
}