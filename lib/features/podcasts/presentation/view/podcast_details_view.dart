import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/podcasts/presentation/controller/podcast_details_cubit.dart';
import 'package:graduationproject/features/podcasts/presentation/view/podcasts_view.dart';
import 'package:graduationproject/features/podcasts/presentation/view/widgets/podcast_details_view_body.dart';

import '../../domain/repo/podcast_repo.dart';

class PodcastDetailsView extends StatelessWidget {
  const PodcastDetailsView({super.key, required this.podcastId});

  static const String routeName = '/podcast-details';

  final String podcastId;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PodcastDetailsCubit(
        podcastRepo: getIt<PodcastRepo>(),
      )..getPodcastDetails(podcastId),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: const PodcastDetailsViewBody(),
        appBar: buildAppBar(
          context,
          title: S.of(context).podcast_details,
          navigateTo: PodcastsView.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
      ),
    );
  }
}