import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:waved_audio_player/waved_audio_player.dart';
import 'package:graduationproject/core/utils/app_color.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/core/utils/styles.dart';

import '../../../../../generated/l10n.dart';

class AudioPlayerWidget extends StatelessWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimensions.paddingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.greyLightColor.withOpacity(0.1),
            AppColors.greyLightColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyLightColor.withOpacity(0.2),
            blurRadius: Dimensions.boxHeight8,
            offset: Offset(0, Dimensions.boxHeight4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
        child: WavedAudioPlayer(
          source: UrlSource(audioUrl),
          iconColor: Colors.white,
          iconBackgoundColor: AppColors.secondaryColor,
          playedColor: AppColors.secondaryColor,
          unplayedColor: AppColors.greyLightColor.withOpacity(0.3),
          waveWidth: MediaQuery.of(context).size.width - 12 * Dimensions.paddingMedium,
          barWidth: 2.0,
          buttonSize: Dimensions.iconSizeLarge,
          showTiming: true,
          timingStyle: AppStyles.text12Regular.copyWith(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w600,
          ),
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                S.of(context).try_again,
                  style: AppStyles.text14Regular.copyWith(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.secondaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}