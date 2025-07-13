import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../generated/l10n.dart';
class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
                minFontSize: 0,
            S.of(context).or_create_account_with,
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          // Social icons
          Row(
            children: [
              SocialMedia(
                assetPath: AssetsPath.signupFacebook,
                onTap: () {},
              ),
              const SizedBox(width: 20),
              SocialMedia(
                assetPath: AssetsPath.signupGoogle,
                onTap: () {},
              ),
              const SizedBox(width: 20),
              SocialMedia(
                assetPath: AssetsPath.signupLinkedin,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
