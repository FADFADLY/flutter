import 'package:graduationproject/core/constants/imports.dart';

import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.style,
    required this.textStyle,
  });

  final void Function()? onPressed;
  final String text;
  final Color backgroundColor;
  final ButtonStyle style;

  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.buttonHeight40,
      child: TextButton(
        style: style,
        onPressed: onPressed,
        child: AutoSizeText
                (minFontSize: 0, text, style: textStyle,
        ),
      ),
    );
  }
}
