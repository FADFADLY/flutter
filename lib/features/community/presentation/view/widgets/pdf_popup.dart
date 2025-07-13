import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

void showPdfPopup(BuildContext context, String pdfUrl) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: S.of(context).file_preview,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final frameWidth = screenWidth;
      final frameHeight = screenHeight;

      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.blackColor.withOpacity(0.7),
          body: Center(
            child: Container(
              width: frameWidth,
              height: frameHeight,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius:
                BorderRadius.circular(Dimensions.borderRadiusMediumLarge),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.1),
                    blurRadius: Dimensions.boxHeight10,
                    offset: Offset(0, Dimensions.boxHeight5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                      height:
                      MediaQuery.of(context).padding.top + Dimensions.boxHeight10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: AppColors.errorColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: Dimensions.boxWidth10),
                    ],
                  ),
                  Expanded(
                    child: PDF(
                      swipeHorizontal: false,
                    ).cachedFromUrl(
                      pdfUrl,
                      errorWidget: (dynamic error) =>
                          Center(child: AutoSizeText(error.toString())),
                    ),
                  ),
                ],
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