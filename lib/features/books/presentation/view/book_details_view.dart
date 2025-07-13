import 'package:graduationproject/features/books/presentation/view/widgets/book_details_view_body.dart';
import '../../../../../core/constants/imports.dart';
import '../../domain/repo/book_repo.dart';
import '../controller/cubits/book_details_cubit.dart';
import '../controller/cubits/reaction_cubit.dart';
import 'book_view.dart';

class BookDetailsView extends StatelessWidget {
  final int bookId;

  const BookDetailsView({super.key, required this.bookId});

  static const routeName = '/book/details';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => BookDetailsCubit(bookRepo: getIt<BookRepo>())..getBookDetails(bookId),
),
    BlocProvider(
      create: (context) => BooksReactionCubit(
        bookRepo: getIt<BookRepo>(),
      ),
    ),
  ],
  child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).book_details,
          navigateTo: BookView.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: BookDetailsViewBody(bookId: bookId),
      ),
);
  }
}