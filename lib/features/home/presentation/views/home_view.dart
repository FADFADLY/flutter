import 'package:graduationproject/features/home/presentation/views/widgets/grid_builder.dart';
import 'package:graduationproject/features/home/presentation/views/widgets/start_button_and_mood.dart';
import '../../../../core/constants/imports.dart';
import '../../../../core/utils/dimensions.dart';
import 'NavBar.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context,
          title: '',
          showBackButton: false,
          backgroundColor: AppColors.secondaryColor),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingMedium,
          vertical: Dimensions.paddingSmall,
        ),
        child: Column(
          children: [
            StartButtonMood(),
            GridBuilder(),
          ],
        ),
      ),
    );
  }
}