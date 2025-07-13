import '../../../../../core/constants/imports.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/book_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../book_details_view.dart';

class BookViewBody extends StatelessWidget {
  const BookViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        if (state is BookLoading) {
          return Skeletonizer(
            enabled: true,
            child: GridView.builder(
              padding: EdgeInsets.all(Dimensions.paddingExtraSmall), // 8.0
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: Dimensions.paddingExtraSmall, // 8.0
                mainAxisSpacing: Dimensions.paddingExtraSmall, // 8.0
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium)), // 12
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(Dimensions.paddingExtraSmall), // 8.0
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall), // 8
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.paddingExtraSmall), // 8.0
                        child: Container(
                          height: Dimensions.boxHeight16, // 16
                          margin: EdgeInsets.symmetric(horizontal: Dimensions.boxHeight12), // 12
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall), // 8
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingExtraSmall, vertical: Dimensions.boxHeight4), // 4.0, 8.0
                        child: Container(
                          height: Dimensions.boxHeight14, // 14
                          margin: EdgeInsets.symmetric(horizontal: Dimensions.boxHeight20), // 20
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall), // 8
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is BookLoaded) {
          return GridView.builder(
            padding: EdgeInsets.all(Dimensions.paddingExtraSmall), // 8.0
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: Dimensions.paddingExtraSmall, // 8.0
              mainAxisSpacing: Dimensions.paddingExtraSmall, // 8.0
            ),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    BookDetailsView.routeName,
                    arguments: book.id,
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium)), // 12
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.borderRadiusMedium)), // 12
                          child: Image.network(
                            book.cover,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.paddingExtraSmall), // 8.0
                        child: Text(
                          book.title,
                          textAlign: TextAlign.center,
                          style: AppStyles.text18Bold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is BookError) {
          return EmptyNoData(
            height: Dimensions.boxHeight250 ,
          );
        } else {
          return Center(
              child: Text('Initial state', style: AppStyles.text18Regular));
        }
      },
    );
  }
}