import 'package:flutter/services.dart';
import 'package:graduationproject/core/constants/imports.dart';

AppBar buildAppBar(
    context, {
      required String title,
      Color? backgroundColor,
      bool showBackButton = true,
      String? navigateTo,
    }) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
    ),
    backgroundColor: backgroundColor,
    leading: showBackButton
        ? IconButton(
      onPressed: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else if (navigateTo != null) {
          Navigator.pushNamed(context, navigateTo);
        } else {
          print("Back button pressed, but no navigateTo provided.");
        }
      },
      icon: const Icon(Icons.arrow_back, color: Colors.white),
    )
        : const SizedBox.shrink(), // لمنع الزر التلقائي تمامًا
    title: AutoSizeText(
      title,
      minFontSize: 0,
      textAlign: TextAlign.center,
      style: AppStyles.text24SemiBold,
    ),
    centerTitle: true,
  );
}
