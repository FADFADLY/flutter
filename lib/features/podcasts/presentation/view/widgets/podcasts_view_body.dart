import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:graduationproject/features/podcasts/presentation/view/podcast_details_view.dart';
import '../../../../../core/shared_widgets/empty_no_data.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../controller/podcast_cubit.dart';
import '../../controller/reaction_cubit.dart';

class PodcastsViewBody extends StatefulWidget {
  const PodcastsViewBody({super.key});

  @override
  State<PodcastsViewBody> createState() => _PodcastsViewBodyState();
}

class _PodcastsViewBodyState extends State<PodcastsViewBody> {
  final Set<String> _likedPodcastIds = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(Dimensions.paddingMedium),
          child: SvgPicture.asset(
            Assets.podcastsPodcast,
            fit: BoxFit.contain,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(Dimensions.paddingMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.borderRadiusMediumLarge),
                topRight: Radius.circular(Dimensions.borderRadiusMediumLarge),
              ),
              color: AppColors.backgroundColor,
            ),
            child: BlocBuilder<PodcastCubit, PodcastState>(
              builder: (context, state) {
                if (state is PodcastLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingMedium, vertical: Dimensions.boxHeight8),
                          title: Text(
                            'Podcast Name Placeholder',
                            style: AppStyles.text16Bold,
                          ),
                          subtitle: Text(
                            'Publisher Placeholder',
                            style: AppStyles.text14Regular.copyWith(color: AppColors.greyColor),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusExtraSmall),
                            child: Container(
                              width: Dimensions.boxHeight50,
                              height: Dimensions.boxHeight50,
                              color: AppColors.greyLightColor,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is PodcastLoaded) {
                  return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: state.podcasts.length,
                    itemBuilder: (context, index) {
                      final podcast = state.podcasts[index];
                      bool isLiked = _likedPodcastIds.contains(podcast.podcastId);

                      return Container(
                        margin: EdgeInsets.symmetric(vertical: Dimensions.boxHeight8),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PodcastDetailsView(podcastId: podcast.podcastId),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingMedium, vertical: Dimensions.boxHeight8),
                                  title: Text(
                                    podcast.podcastName,
                                    style: AppStyles.text16Bold,
                                  ),
                                  subtitle: Text(
                                    podcast.publisher,
                                    style: AppStyles.text14Regular.copyWith(color: AppColors.greyColor),
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusExtraSmall),
                                    child: Image.network(
                                      podcast.image,
                                      width: Dimensions.boxHeight50,
                                      height: Dimensions.boxHeight50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          SvgPicture.asset(
                                            Assets.podcastsPodcast,
                                            fit: BoxFit.contain,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final cubit = context.read<ReactionCubit>();
                                setState(() {
                                  if (isLiked) {
                                    _likedPodcastIds.remove(podcast.podcastId);
                                  } else {
                                    _likedPodcastIds.add(podcast.podcastId);
                                  }
                                });
                                await cubit.toggleReaction(podcast.podcastId);
                                final reactionState = cubit.state;
                                if (reactionState is ReactionLoaded) {
                                  if (reactionState.response.message == S.of(context).like_added_success) {
                                    if (!isLiked) _likedPodcastIds.add(podcast.podcastId);
                                  } else if (reactionState.response.message == S.of(context).like_removed_success) {
                                    if (isLiked) _likedPodcastIds.remove(podcast.podcastId);
                                  }
                                  setState(() {});
                                }
                              },
                              child: Container(
                                width: Dimensions.boxHeight50,
                                height: Dimensions.boxHeight50,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.borderRadiusXLarge)),
                                ),
                                child: Icon(
                                  isLiked || state.podcasts[index].reacted ? Icons.favorite : Icons.favorite_outline,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is PodcastError) {
                  return EmptyNoData(
                    height: Dimensions.boxHeight170,
                  );
                } else {
                  return Center(child: Text(S.of(context).no_data));
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}