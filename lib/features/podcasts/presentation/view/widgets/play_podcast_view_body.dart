import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/podcast_details_cubit.dart';

class PlayPodcastViewBody extends StatefulWidget {
  const PlayPodcastViewBody({super.key});

  @override
  State<PlayPodcastViewBody> createState() => _PlayPodcastViewBodyState();
}

class _PlayPodcastViewBodyState extends State<PlayPodcastViewBody> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
