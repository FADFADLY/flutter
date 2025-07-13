import 'package:graduationproject/features/podcasts/presentation/view/podcast_details_view.dart';
import 'package:graduationproject/features/podcasts/presentation/view/widgets/play_podcast_view_body.dart';

import '../../../../core/constants/imports.dart';

class PlayPodcastView extends StatelessWidget {
  const PlayPodcastView({super.key ,


  });


  static const String routeName = '/play_podcast';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: S.of(context).podcast,
        navigateTo: PodcastDetailsView.routeName,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: PlayPodcastViewBody(

      ),
    );
  }
}