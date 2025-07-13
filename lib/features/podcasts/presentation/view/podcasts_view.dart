import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/podcasts/data/repo_impl/podcast_repo_impl.dart';
import 'package:graduationproject/features/podcasts/domain/repo/podcast_repo.dart';
import 'package:graduationproject/features/podcasts/presentation/view/widgets/podcasts_view_body.dart';
import 'package:graduationproject/features/home/presentation/views/NavBar.dart';

import '../../../habits/presentation/presentation/views/relaxation_view.dart';
import '../controller/podcast_cubit.dart';
import '../controller/reaction_cubit.dart';

class PodcastsView extends StatelessWidget {
  const PodcastsView({super.key});

  static const String routeName = '/podcasts';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          PodcastCubit(
            podcastRepo: getIt<PodcastRepo>(),
          )
            ..getPodcasts(),
        ),
        BlocProvider(
          create: (context) => ReactionCubit(
            reactionRepo: getIt<PodcastRepo>(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: buildAppBar(
          context,
          title: S.of(context).podcasts,
          navigateTo: RelaxationView.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: const PodcastsViewBody(),
      ),
    );
  }
}