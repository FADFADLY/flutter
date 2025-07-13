import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/vote_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/comments_reaction_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/store_comment_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/get_comments_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/delete_post_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/get_posts_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/reaction_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/store_post_cubit.dart';
import 'package:graduationproject/features/community/presentation/controller/cubits/update_comment_cubit.dart';
import 'package:graduationproject/features/community/presentation/view/widgets/community_view_body.dart';
import 'package:graduationproject/features/home/presentation/views/NavBar.dart';

import '../../domain/repo/repo.dart';
import '../controller/cubits/delete_comment_cubit.dart';
import '../controller/cubits/update_post_cubit.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  static const String routeName = '/community';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CommentsReactionCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => DeletePostCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => GetPostsCubit(postsRepo: getIt<PostsRepo>())..getPosts()),
        BlocProvider(create: (context) => ReactionsCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => VoteCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => StoreCommentCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => GetCommentsCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => UpdateCommentCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => DeleteCommentCubit(postsRepo: getIt<PostsRepo>())),
        BlocProvider(create: (context) => UpdatePostCubit(postsRepo: getIt<PostsRepo>())),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: buildAppBar(
          context,
          title: S.of(context).community,
          navigateTo: BottomNavBar.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: const CommunityViewBody(),
      ),
    );
  }
}