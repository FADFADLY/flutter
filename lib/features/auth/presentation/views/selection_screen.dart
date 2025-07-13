import 'package:graduationproject/core/constants/imports.dart';

import '../../../../core/constants/strings.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  static const routeName = Strings.selectionScreenRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SelectionScreenBody(),
    );
  }
}