import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/generated/assets.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../home/presentation/views/NavBar.dart';
import '../../../../podcasts/presentation/view/podcast_details_view.dart';
import '../../../domain/repo/repo.dart';
import '../../controller/cubit/liked_podcast_cubit.dart';

class LikedPodcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikedPodcastsCubit(
        profileRepo: getIt<ProfileRepo>(),
      )..getLikedPodcasts(),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: S.of(context).liked_podcasts,
          navigateTo: BottomNavBar.routeName,
          backgroundColor: AppColors.secondaryColor,
        ),
        body: Column(
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
                child: BlocBuilder<LikedPodcastsCubit, LikedPodcastState>(
                  builder: (context, state) {
                    if (state is LikedPodcastLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingMedium,
                                  vertical: Dimensions.boxHeight8),
                              title: Text(
                                'Podcast Name Placeholder',
                                style: AppStyles.text16Bold,
                              ),
                              subtitle: Text(
                                'Publisher Placeholder',
                                style: AppStyles.text14Regular.copyWith(
                                    color: AppColors.greyColor),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusExtraSmall),
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
                    } else if (state is LikedPodcastLoaded) {
                      return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.podcasts.length,
                        itemBuilder: (context, index) {
                          final podcast = state.podcasts[index];
                          return Container(
                            margin:
                            EdgeInsets.symmetric(vertical: Dimensions.boxHeight8),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(

                                  context,
                                  PodcastDetailsView.routeName,
                                  arguments: podcast.podcastId,
                                );
                              },
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingMedium,
                                    vertical: Dimensions.boxHeight8),
                                title: Text(
                                  podcast.podcastName,
                                  style: AppStyles.text16Bold,
                                ),
                                subtitle: Text(
                                  podcast.publisher,
                                  style: AppStyles.text14Regular.copyWith(
                                      color: AppColors.greyColor),
                                ),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusExtraSmall),
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
                          );
                        },
                      );
                    } else if (state is LikedPodcastError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: Text(S.of(context).no_data));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}