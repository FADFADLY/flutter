import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/cubits/book_details_cubit.dart';
import '../../controller/cubits/reaction_cubit.dart';

class BookDetailsViewBody extends StatefulWidget {
  final int bookId;

  const BookDetailsViewBody({super.key, required this.bookId});

  @override
  State<BookDetailsViewBody> createState() => _BookDetailsViewBodyState();
}

class _BookDetailsViewBodyState extends State<BookDetailsViewBody> {
  bool _isLiked = false; // Local state for favorite icon

  @override
  void initState() {
    super.initState();
    // Fetch book details when the widget is initialized
    context.read<BookDetailsCubit>().getBookDetails(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookDetailsCubit, BookDetailsState>(
      listener: (context, state) {
        if (state is BookDetailsLoaded) {
          // Sync local isLiked with backend data when details are loaded
          setState(() {
            _isLiked = state.details.reacted;
          });
        }
      },
      builder: (context, state) {
        if (state is BookDetailsLoading) {
          return Skeletonizer(
            enabled: true,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingMedium),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimensions.boxHeight200,
                        width: Dimensions.boxHeight130,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight6),
                              child: Container(
                                height: Dimensions.boxHeight16,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: Dimensions.boxHeight20,
                    width: Dimensions.boxHeight100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(4, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.boxHeight6),
                      child: Container(
                        height: Dimensions.boxHeight14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        } else if (state is BookDetailsLoaded) {
          final book = state.details;
          return SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
                      child: Image.network(
                        book.cover,
                        fit: BoxFit.cover,
                        height: Dimensions.boxHeight200,
                        width: Dimensions.boxHeight130,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AutoSizeText(
                                  book.title,
                                  style: AppStyles.text20Bold,
                                  maxLines: 2,
                                  minFontSize: 0,
                                ),
                              ),
                              const Spacer(),
                              BlocConsumer<BooksReactionCubit, BooksReactionState>(
                                listener: (context, reactionState) {
                                  if (reactionState is BooksReactionError) {
                                    // Revert local state if the backend request fails
                                    setState(() {
                                      _isLiked = !_isLiked;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(reactionState.message)),
                                    );
                                  }
                                },
                                builder: (context, reactionState) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Optimistically update local state
                                      setState(() {
                                        _isLiked = !_isLiked;
                                      });
                                      // Trigger backend reaction toggle
                                      context
                                          .read<BooksReactionCubit>()
                                          .toggleReaction(widget.bookId.toString());
                                    },
                                    child: Container(
                                      width: Dimensions.boxHeight50,
                                      height: Dimensions.boxHeight50,
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.borderRadiusXLarge),
                                        ),
                                      ),
                                      child: reactionState is BooksReactionLoading
                                          ? CircularProgressIndicator(
                                        color: AppColors.whiteColor,
                                        strokeWidth: 2,
                                      )
                                          : Icon(
                                        _isLiked ? Icons.favorite : Icons.favorite_outline,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _infoText(S.of(context).author, book.author),
                          _infoText(S.of(context).publisher, book.publisher),
                          _infoText(S.of(context).publication_date, book.publicationDate),
                          _infoText(S.of(context).pages_count, book.pagesCount.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(S.of(context).description, style: AppStyles.text20Bold),
                const SizedBox(height: 8),
                Text(
                  book.description,
                  style: AppStyles.text16Regular,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          );
        } else if (state is BookDetailsError) {
          return Center(child: Text(state.message, style: AppStyles.text18Regular));
        } else {
          return const Center(child: Text('Initial state'));
        }
      },
    );
  }

  Widget _infoText(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.boxHeight6),
      child: Text(
        "$label: $value",
        style: AppStyles.text16Regular,
      ),
    );
  }
}