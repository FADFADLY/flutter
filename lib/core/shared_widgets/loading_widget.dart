import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/imports.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: AppColors.backgroundColor,
      child: Center(
        child: SpinKitPumpingHeart(
          color: AppColors.secondaryColor,
          size: 75.0,
        ),
      ),
    );
  }
}