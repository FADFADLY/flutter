import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/constants/imports.dart';
import '../../../../../core/utils/dimensions.dart';
import '../article.dart';

class ArticleCard extends StatefulWidget {
  final String title;
  final String author;
  final String date;
  final String imageUrl;
  final int likes;
  final int shares;
  final int views;
  final bool isLoading;
  final String summery;
  final int id;

  const ArticleCard({
    super.key,
    required this.title,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.likes,
    required this.shares,
    required this.views,
    this.isLoading = false,
    required this.summery,
    required this.id,
  });

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  bool isExpanded = false;

  static var _subtitleStyle = AppStyles.text20Subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Card(
        margin: EdgeInsets.all(Dimensions.paddingSmall),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium)),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingMedium),
          child: Skeletonizer(
            enabled: widget.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(),
                    SizedBox(width: Dimensions.boxHeight12),
                    Expanded(child: _buildTextContent()),
                  ],
                ),
                if (isExpanded) ...[
                  SizedBox(height: Dimensions.boxHeight12),
                  _buildExpandedContent(context),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Skeleton.leaf(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusMedium),
        child: widget.isLoading
            ? Container(
          width: Dimensions.boxHeight100,
          height: Dimensions.boxHeight100,
          color: Colors.grey.withOpacity(0.3),
        )
            : Image.network(
          widget.imageUrl,
          width: Dimensions.boxHeight100,
          height: Dimensions.boxHeight100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image,
            size: 100,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildSkeletonText(
          width: double.infinity,
          height: Dimensions.boxHeight16,
          child: AutoSizeText(
            minFontSize: 0,
            widget.title,
            style: AppStyles.text24SemiBold.copyWith(
              fontSize: Dimensions.fontSize15,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(height: Dimensions.boxHeight15),
        Row(
          children: [
            Expanded(
              child: _buildSkeletonText(
                width: Dimensions.boxHeight100,
                height: Dimensions.boxHeight12,
                child: AutoSizeText(
                  minFontSize: 0,
                  "د/ ${widget.author}",
                  style: _subtitleStyle.copyWith(
                    fontSize: Dimensions.fontSize12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: Dimensions.boxHeight8),
            _buildSkeletonText(
              width: Dimensions.boxHeight60,
              height: Dimensions.boxHeight12,
              child: AutoSizeText(
                minFontSize: 0,
                widget.date,
                style: _subtitleStyle.copyWith(
                  fontSize: Dimensions.fontSize12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.boxHeight15),
        Wrap(
          spacing: Dimensions.boxHeight12,
          runSpacing: Dimensions.boxHeight6,
          alignment: WrapAlignment.spaceBetween,
          children: [
            _buildStat(Icons.favorite, widget.likes),
            _buildStat(Icons.reply, widget.shares),
            _buildStat(Icons.remove_red_eye, widget.views),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          minFontSize: 0,
          widget.summery,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.text20Subtitle.copyWith(
            fontSize: Dimensions.fontSize14,
            color: AppColors.textColor,
          ),
          textAlign: TextAlign.right,
        ),
        SizedBox(height: Dimensions.boxHeight12),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleView(id: widget.id),
                ),
              );
            },
            style: AppStyles.buttonStyle2,
            child: AutoSizeText(
              minFontSize: 0,
              S.of(context).read_more,
              style: AppStyles.text18Button,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkeletonText({
    required double width,
    required double height,
    required Widget child,
  }) {
    return Skeleton.replace(
      replacement: Container(
        width: width,
        height: height,
        color: Colors.grey.withOpacity(0.3),
      ),
      child: child,
    );
  }

  Widget _buildStat(IconData icon, int value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: Dimensions.iconSize, color: AppColors.secondaryColor),
        SizedBox(width: Dimensions.boxHeight4),
        _buildSkeletonText(
          width: Dimensions.boxHeight20,
          height: Dimensions.boxHeight12,
          child: AutoSizeText(
            minFontSize: 0,
            value.toString(),
            style: _subtitleStyle.copyWith(
              fontSize: Dimensions.fontSize12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}