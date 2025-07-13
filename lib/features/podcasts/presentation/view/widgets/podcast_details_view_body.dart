import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/podcasts/presentation/controller/podcast_details_cubit.dart';
import 'package:graduationproject/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../domain/repo/podcast_repo.dart';

class PodcastDetailsViewBody extends StatelessWidget {
  const PodcastDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        BlocBuilder<PodcastDetailsCubit, PodcastDetailsState>(
          builder: (context, state) {
            if (state is PodcastDetailsLoading) {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyLightColor,
                  ),
                ),
              );
            } else if (state is PodcastDetailsLoaded) {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.podcastDetails.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            } else if (state is PodcastDetailsLoadingAudio) {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.podcastDetails.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            } else {
              return Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight * 0.35,
                  width: double.infinity,
                  color: AppColors.greyLightColor,
                  child: Center(
                    child: Text(
                      S.of(context).no_image,
                      style: AppStyles.text16Regular,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        Positioned(
          top: Dimensions.boxHeight250,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(Dimensions.paddingSmall),
            height: Dimensions.boxHeight700,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.borderRadiusLarge),
                topRight: Radius.circular(Dimensions.borderRadiusLarge),
              ),
            ),
            child: BlocBuilder<PodcastDetailsCubit, PodcastDetailsState>(
              builder: (context, state) {
                if (state is PodcastDetailsLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(Dimensions.boxHeight8),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: Dimensions.boxHeight30,
                              backgroundColor: AppColors.greyLightColor,
                            ),
                            title: Text(
                              "Podcast Name Placeholder",
                              style: AppStyles.text16Bold,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is PodcastDetailsLoaded) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Dimensions.boxHeight700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.boxHeight16,
                                    vertical: Dimensions.boxHeight8,
                                  ),
                                  child: AutoSizeText(
                                    state.podcastDetails.title,
                                    minFontSize: 0,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.text18SemiBold.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.boxHeight16),
                                  child: AutoSizeText(
                                    state.podcastDetails.publisher,
                                    minFontSize: 0,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.text14Regular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.boxHeight10),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.podcastDetails.episodes.length,
                              itemBuilder: (context, index) {
                                final episode = state.podcastDetails.episodes[index];
                                return Padding(
                                  padding: EdgeInsets.all(Dimensions.boxHeight8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: CircleAvatar(
                                            radius: Dimensions.boxHeight30,
                                            backgroundImage: NetworkImage(episode.image),
                                            onBackgroundImageError: (error, stackTrace) =>
                                                SvgPicture.asset(
                                                  Assets.podcastsPodcast,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                          title: Text(
                                            episode.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.text16Regular.copyWith(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.boxHeight10),
                                      GestureDetector(
                                        onTap: () {
                                          _showPlayerDialog(context: context,episode: episode , state: state);
                                        },
                                        child: Container(
                                          width: Dimensions.boxHeight50,
                                          height: Dimensions.boxHeight50,
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimensions.borderRadiusXLarge)),
                                          ),
                                          child: _buildPlayButton(state, episode.id),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is PodcastDetailsLoadingAudio) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: Dimensions.boxHeight700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.boxHeight16,
                                    vertical: Dimensions.boxHeight8,
                                  ),
                                  child: AutoSizeText(
                                    state.podcastDetails.title,
                                    minFontSize: 0,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.text20Regular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.boxHeight16),
                                  child: AutoSizeText(
                                    state.podcastDetails.publisher,
                                    minFontSize: 0,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.text14Regular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.boxHeight10),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.podcastDetails.episodes.length,
                              itemBuilder: (context, index) {
                                final episode = state.podcastDetails.episodes[index];
                                return Padding(
                                  padding: EdgeInsets.all(Dimensions.boxHeight8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: CircleAvatar(
                                            radius: Dimensions.boxHeight30,
                                            backgroundImage: NetworkImage(episode.image),
                                            onBackgroundImageError: (error, stackTrace) =>
                                                SvgPicture.asset(
                                                  Assets.podcastsPodcast,
                                                  fit: BoxFit.contain,
                                                ),
                                          ),
                                          title: Text(
                                            episode.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyles.text16Regular.copyWith(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.boxHeight10),
                                      GestureDetector(
                                        onTap: () {
                                          _showPlayerDialog(
                                            context: context,
                                            episode: episode,
                                            state: state,
                                          );
                                        },
                                        child: Container(
                                          width: Dimensions.boxHeight50,
                                          height: Dimensions.boxHeight50,
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(Dimensions.borderRadiusXLarge)),
                                          ),
                                          child: state.episodeId == episode.id
                                              ? CircularProgressIndicator(
                                            color: AppColors.whiteColor,
                                          )
                                              : Icon(
                                            Icons.play_arrow,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is PodcastDetailsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          style: AppStyles.text16Regular,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimensions.boxHeight10),
                        ElevatedButton(
                          onPressed: () {
                            final currentCubit = context.read<PodcastDetailsCubit>();
                            if (currentCubit.state is PodcastDetailsLoaded) {
                              final loadedState = currentCubit.state as PodcastDetailsLoaded;
                              _showPlayerDialog(
                                context: context,
                                episode: loadedState.podcastDetails.episodes.first,
                                state: loadedState,
                              );
                            }
                          },
                          child: Text(S.of(context).try_again),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      S.of(context).no_data,
                      style: AppStyles.text16Regular,
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayButton(PodcastDetailsState state, String episodeId) {
    if (state is PodcastDetailsLoaded) {
      final isPlaying = state.isPlaying && state.playingEpisodeId == episodeId;
      return isPlaying
          ? Icon(Icons.pause, color: AppColors.whiteColor)
          : Icon(Icons.play_arrow, color: AppColors.whiteColor);
    }
    return Icon(Icons.play_arrow, color: AppColors.whiteColor);
  }

  void _showPlayerDialog(

  {

  required BuildContext context ,dynamic episode, required PodcastDetailsState state
}  ) {
    final audioPlayer = AudioPlayer();
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
  create: (context) => PodcastDetailsCubit(
    podcastRepo: getIt<PodcastRepo>(),
  ),
  child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final isPlaying = playerState?.playing ?? false;

                // Show loading indicator when buffering or loading
                final showLoading = processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering;

                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusLarge),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.paddingMedium),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Episode Image
                        CircleAvatar(
                          radius: Dimensions.boxHeight50,
                          backgroundImage: NetworkImage(episode.image),
                          onBackgroundImageError: (error, stackTrace) =>
                              SvgPicture.asset(
                                Assets.podcastsPodcast,
                                fit: BoxFit.contain,
                              ),
                        ),
                        SizedBox(height: Dimensions.boxHeight10),
                        // Episode Title
                        Text(
                          episode.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.text18SemiBold.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                        SizedBox(height: Dimensions.boxHeight10),
                        // Progress Slider
                        StreamBuilder<Duration?>(
                          stream: audioPlayer.positionStream,
                          builder: (context, snapshot) {
                            final position = snapshot.data ?? Duration.zero;
                            final duration = audioPlayer.duration ?? Duration.zero;
                            return Column(
                              children: [
                                Slider(
                                  value: position.inSeconds.toDouble(),
                                  max: duration.inSeconds.toDouble() > 0
                                      ? duration.inSeconds.toDouble()
                                      : 1.0,
                                  onChanged: (value) {
                                    audioPlayer.seek(Duration(seconds: value.toInt()));
                                  },
                                  activeColor: AppColors.secondaryColor,
                                  inactiveColor: AppColors.greyLightColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDuration(position),
                                        style: AppStyles.text12Regular.copyWith(
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(duration),
                                        style: AppStyles.text12Regular.copyWith(
                                          color: AppColors.greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        // Playback Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Rewind Button
                            IconButton(
                              icon: Icon(
                                Icons.replay_10,
                                color: AppColors.greyColor,
                                size: Dimensions.boxHeight24,
                              ),
                              onPressed: () {
                                final newPosition =
                                    audioPlayer.position - Duration(seconds: 10);
                                audioPlayer.seek(newPosition >= Duration.zero
                                    ? newPosition
                                    : Duration.zero);
                              },
                            ),
                            // Play/Pause Button with loading indicator
                            Container(
                              width: Dimensions.boxHeight50,
                              height: Dimensions.boxHeight50,
                              margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
                              child: showLoading
                                  ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.secondaryColor,
                                ),
                              )
                                  : IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: AppColors.secondaryColor,
                                  size: Dimensions.boxHeight30,
                                ),
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (!isPlaying) {
                                      await audioPlayer.setUrl(episode.audio);
                                      await audioPlayer.play();
                                    } else {
                                      await audioPlayer.pause();
                                    }
                                    context
                                        .read<PodcastDetailsCubit>()
                                        .togglePlayPause(episode.id, episode.audio);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error playing audio: $e'),
                                      ),
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            // Fast Forward Button
                            IconButton(
                              icon: Icon(
                                Icons.forward_10,
                                color: AppColors.greyColor,
                                size: Dimensions.boxHeight24,
                              ),
                              onPressed: () {
                                final newPosition =
                                    audioPlayer.position + Duration(seconds: 10);
                                final duration = audioPlayer.duration ?? Duration.zero;
                                audioPlayer.seek(newPosition <= duration
                                    ? newPosition
                                    : duration);
                              },
                            ),
                          ],
                        ),
                        // Close Button
                        TextButton(
                          onPressed: () {
                            audioPlayer.stop();
                            audioPlayer.dispose();
                            Navigator.of(dialogContext).pop();
                          },
                          child: Text(
                            S.of(context).close,
                            style: AppStyles.text16Regular.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
);
      },
    ).then((_) {
      audioPlayer.stop();
      audioPlayer.dispose();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}