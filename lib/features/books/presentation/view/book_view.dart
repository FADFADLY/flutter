import 'package:graduationproject/features/books/presentation/view/widgets/book_view_body.dart';
import '../../../../../core/constants/imports.dart';
import '../../../habits/presentation/presentation/views/habit_tracker_view.dart';
import '../../domain/repo/book_repo.dart';
import '../controller/cubits/book_cubit.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  static const routeName = '/book';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookCubit(bookRepo: getIt<BookRepo>())..getBooks(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).reading,
          navigateTo: HabitTrackerView.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: BookViewBody(),
      ),
    );
  }
}