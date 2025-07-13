import 'package:graduationproject/features/profile/presentation/view/widgets/profile_view_body.dart';
import '../../../../core/constants/imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: buildAppBar(
        context,
        title: S.of(context).profile,
        showBackButton: false,
        backgroundColor: AppColors.secondaryColor,
      ),
      body: ProfileViewBody(),
    );
  }
}