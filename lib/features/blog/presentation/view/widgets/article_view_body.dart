import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/constants/imports.dart';
import '../../controller/cubits/single_article_cubit/single_article_cubit.dart';
import '../../controller/cubits/blog_reaction/blog_reaction_cubit.dart';

class ArticleViewBody extends StatelessWidget {
  const ArticleViewBody({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleArticleCubit, SingleArticleState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is SingleArticleLoading,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                ArticleViewBodyImage(
                  imageUrl: state is SingleArticleLoaded
                      ? state.article.image
                      : 'https://via.placeholder.com/150',
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: state is SingleArticleLoaded
                      ? Content(
                    reacted: state.article.reacted,
                    id: id,
                    title: state.article.title,
                    author: state.article.author,
                    date: state.article.createdAt,
                    likes: state.article.likes,
                    shares: state.article.share,
                    views: state.article.views,
                    content: state.article.body,
                  )
                      : Content(
                    reacted: false,
                    id: id,
                    title: 'Placeholder Title',
                    author: 'Placeholder Author',
                    date: '2025-05-20',
                    likes: 0,
                    shares: 0,
                    views: 0,
                    content: 'Placeholder content for loading state.',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    required this.title,
    required this.author,
    required this.date,
    required this.likes,
    required this.shares,
    required this.views,
    required this.content,
    super.key,
    required this.id,
    required this.reacted,
  });

  final bool reacted;
  final String title;
  final String author;
  final String date;
  final String content;
  final int likes;
  final int shares;
  final int id;
  final int views;

  @override
  Widget build(BuildContext context) {
    // هنضمن إن الـ BlogReactionCubit يتعامل مع القيم اللي جاية من الـ backend
    context.read<BlogReactionCubit>().initializeReaction(
      reacted: reacted,
      likes: likes,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildSkeletonText(

              width: double.infinity,
              height: 24,
              child: AutoSizeText(
                minFontSize: 0,
                title,
                style: AppStyles.text24SemiBold,
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              _buildSkeletonText(

                  width: 80,
                  height: 16,
                  child: AutoSizeText(
                minFontSize: 0,
                    date,
                    style: AppStyles.text20Subtitle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Spacer(),
                _buildSkeletonText(
                  width: 100,
                  height: 16,
                  child: AutoSizeText(
                minFontSize: 0,
                    "د/ $author",
                    style: AppStyles.text20Subtitle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSkeletonText(
              width: double.infinity,
              height: 100,
              child: AutoSizeText(
                minFontSize: 0,
                content,
                textAlign: TextAlign.right,
                style: AppStyles.text20Subtitle.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocBuilder<BlogReactionCubit, BlogReactionState>(
                  builder: (context, state) {
                    final cubit = context.read<BlogReactionCubit>();
                    bool isLiked = cubit.isLiked; // بنستخدم الـ isLiked من الـ Cubit
                    int displayedLikes = cubit.likeCount; // بنستخدم الـ likeCount من الـ Cubit

                    return GestureDetector(
                      onTap: () {
                        context.read<BlogReactionCubit>().toggleReaction(id: id);
                      },
                      child: _buildStat(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        displayedLikes,
                      ),
                    );
                  },
                ),
                _buildStat(Icons.share, shares),
                _buildStat(Icons.remove_red_eye, views),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonText(
               {
    required double width,
    required double height,
    required Widget child,
  }) {
    return Skeleton.replace(
      replacement: Container(
        width: width,
        height: height,
        color: Colors.grey[300],
      ),
      child: child,
    );
  }

  Widget _buildStat(IconData icon, int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Skeleton.leaf(
          child: Icon(icon, size: 20, color: Colors.blue),
        ),
        const SizedBox(width: 4),
        _buildSkeletonText(

          width: 20,
          height: 16,
          child: AutoSizeText(
                minFontSize: 0,
            count.toString(),
            style: AppStyles.text20Subtitle,
          ),
        ),
      ],
    );
  }
}
class ArticleViewBodyImage extends StatelessWidget {
  const ArticleViewBodyImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}