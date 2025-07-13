import 'package:flutter/material.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';

void showImagePopup(BuildContext context, String imagePath) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: S.of(context).image_preview,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Scaffold(
        backgroundColor: AppColors.blackColor.withOpacity(0.95),
        body: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Hero(
              tag: imagePath,
              child: InteractiveViewer(
                panEnabled: true,
                scaleEnabled: true,
                minScale: 1,
                maxScale: 5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}