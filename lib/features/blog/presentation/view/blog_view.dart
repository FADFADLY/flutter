import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/features/blog/presentation/view/widgets/blog_view.dart';
import 'package:graduationproject/features/home/presentation/views/NavBar.dart';
import '../../../../core/constants/imports.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/full_blog/article_cubit.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});

  static const routeName = '/blog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: S.of(context).blog,
        navigateTo: BottomNavBar.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: BlocProvider(
        create: (context) => ArticleCubit(blogRepo: getIt<BlogRepo>())..getArticles(),
        child: const BlogViewBody(),
      ),
    );
  }
}