import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/app_color.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/styles.dart';

class PostContent extends StatelessWidget {
  final String content;
  final bool isExpanded;
  final bool exceedsTwoLines;
  final VoidCallback onToggleExpand;

  const PostContent({
    super.key,
    required this.content,
    required this.isExpanded,
    required this.exceedsTwoLines,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: exceedsTwoLines ? onToggleExpand : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            content,
            style: AppStyles.text14Regular,
            maxLines: isExpanded ? null : 2,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
          ),
          if (!isExpanded && exceedsTwoLines)
            Padding(
              padding: EdgeInsets.only(top: Dimensions.boxHeight4),
              child: AutoSizeText(
                S.of(context).view_more,
                style: AppStyles.text14Bold.copyWith(
                  color: AppColors.secondaryColor,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
        ],
      ),
    );
  }
}