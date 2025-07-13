import 'dart:ui';

class GridItem {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  GridItem({
    required this.title,
    required this.imagePath,
    required this.onPressed,
  });
}