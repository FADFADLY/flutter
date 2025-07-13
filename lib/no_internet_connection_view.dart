import 'package:lottie/lottie.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'core/constants/imports.dart';
import 'core/utils/dimensions.dart';

class NoInternetConnectionView extends StatelessWidget {
  const NoInternetConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/no_connections.json',
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: Dimensions.boxHeight300,
              repeat: true,
              fit: BoxFit.cover,
            ),
            SizedBox(height: Dimensions.boxHeight20),
            AutoSizeText(
              S.of(context).noInternetMessage,
              textAlign: TextAlign.center,
              minFontSize: 0,
              style: AppStyles.text18SemiBold,
            ),
            SizedBox(height: Dimensions.boxHeight20),
SizedBox(
  width: Dimensions.buttonWidth33Percent,
  height: Dimensions.buttonHeight40,
  child: CustomButton(
    onPressed: () async {
      final isConnected = await InternetConnection()
          .hasInternetAccess;
      if (!isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AutoSizeText(
                S
                    .of(context)
                    .stillNoInternet,
              minFontSize: 0,
              style: AppStyles.text18Regular,
              textAlign: TextAlign.center,
            ),
            backgroundColor: AppColors.secondaryColor,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    },
                    text: S.of(context).retry,
                    backgroundColor: AppColors.primaryColor,
                    style: AppStyles.buttonStyle2,
                    textStyle: AppStyles.text12SemiBold,
  ),
)
          ],
        ),
      ),
    );
  }
}