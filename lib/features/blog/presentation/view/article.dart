import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/blog/presentation/controller/cubits/single_article_cubit/single_article_cubit.dart';
import 'package:graduationproject/features/blog/presentation/view/widgets/article_view_body.dart';
import '../../../../core/constants/imports.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/blog_reaction/blog_reaction_cubit.dart';
import '../controller/cubits/full_blog/article_cubit.dart';
import 'blog_view.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.id});

  final int id;

  static const routeName = '/article';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: S.of(context).article,
        navigateTo: BlogView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SingleArticleCubit(blogRepo: getIt<BlogRepo>())..getSingleArticle(id),
          ),
          BlocProvider(
            create: (context) => BlogReactionCubit(blogRepo: getIt<BlogRepo>()),
          ),
        ],
        child: ArticleViewBody(id: id),
      ),
    );
  }
}