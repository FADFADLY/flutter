import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../core/utils/dimensions.dart';

class SkeletonLoaderWidget extends StatelessWidget {
  const SkeletonLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSmall, horizontal: Dimensions.paddingMedium),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.paddingMedium),
              title: AutoSizeText(
                minFontSize: 0,
                S.of(context).chat_skeleton,
                style: AppStyles.text14Bold,
              ),
              subtitle: AutoSizeText(
                minFontSize: 0,
                '2025-05-23 18:44',
                style: AppStyles.text14Regular,
              ),
            ),
          );
        },
      ),
    );
  }
}