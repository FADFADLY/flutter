import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../books/presentation/view/book_details_view.dart';
import '../../../../home/presentation/views/NavBar.dart';
import '../../../domain/repo/repo.dart';
import '../../controller/cubit/liked_book_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LikedBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedBookCubit(
        profileRepo: getIt<ProfileRepo>(),
      )..getLikedBooks(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).liked_books,
          navigateTo: BottomNavBar.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: BlocBuilder<LikedBookCubit, BookLikedState>(
          builder: (context, state) {
            if (state is BookLikedLoading) {
              return Skeletonizer(
                enabled: true,
                child: GridView.builder(
                  padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: Dimensions.paddingExtraSmall,
                    mainAxisSpacing: Dimensions.paddingExtraSmall,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusMedium)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(Dimensions.paddingExtraSmall),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                BorderRadius.circular(Dimensions.borderRadiusSmall),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
                            child: Container(
                              height: Dimensions.boxHeight16,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.boxHeight12),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                BorderRadius.circular(Dimensions.borderRadiusSmall),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingExtraSmall,
                                vertical: Dimensions.boxHeight4),
                            child: Container(
                              height: Dimensions.boxHeight14,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.boxHeight20),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                BorderRadius.circular(Dimensions.borderRadiusSmall),
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
            } else if (state is BookLikedLoaded) {
              return GridView.builder(
                padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: Dimensions.paddingExtraSmall,
                  mainAxisSpacing: Dimensions.paddingExtraSmall,
                ),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsView(
                            bookId: book.id,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusMedium)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(Dimensions.borderRadiusMedium)),
                              child: Image.network(
                                book.cover,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimensions.paddingExtraSmall),
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
            } else if (state is BookLikedError) {
              return Center(
                  child: Text(state.message, style: AppStyles.text18Regular));
            } else {
              return Center(
                  child: Text('Initial state', style: AppStyles.text18Regular));
            }
          },
        ),
      ),
    );
  }
}