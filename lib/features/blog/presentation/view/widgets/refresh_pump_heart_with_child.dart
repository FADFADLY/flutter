import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../core/utils/dimensions.dart';

class RefreshPumpHeartWithChild extends StatelessWidget {
  const RefreshPumpHeartWithChild({
    this.child,
    super.key,
    required this.showPumpHeart,
    required this.offset,
    required this.controller,
  });

  final Widget? child;
  final IndicatorController controller;
  final bool showPumpHeart;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final offset = controller.value * Dimensions.boxHeight50;
        final showPumpHeart = controller.value > 0;

        return Column(
          children: [
            Container(
              height: Dimensions.boxHeight60 * controller.value.clamp(0.5, 1.0),
              alignment: Alignment.center,
              child: showPumpHeart
                  ? SpinKitPumpingHeart(
                color: AppColors.secondaryColor,
                size: Dimensions.iconHeartSize * controller.value.clamp(0.8, 1.0),
              )
                  : const SizedBox(),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(0, offset),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}