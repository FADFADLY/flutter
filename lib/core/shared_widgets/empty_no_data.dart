import 'package:lottie/lottie.dart';

import '../constants/imports.dart';
import '../../generated/assets.dart';

class EmptyNoData extends StatelessWidget {
  const EmptyNoData({
    super.key,
    required this.height,
  });

  final double height ;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
          height: height,
          fit: BoxFit.cover,
          animate: true,
          Assets.assetsEmpty),
    );
  }
}
