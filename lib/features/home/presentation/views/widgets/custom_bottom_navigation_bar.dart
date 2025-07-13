// import 'package:flutter/cupertino.dart';
// import '../../../../../core/constants/imports.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import '../../../../../core/utils/dimensions.dart';
// import '../../../../notifications/presentation/views/notification_view.dart';
// import '../../../../profile/presentation/view/profile_view.dart';
// import '../NavBar.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
//
//   CustomBottomNavigationBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: const [
//         BottomNavBar(),
//         NotificationView(),
//         ProfileView(),
//         Placeholder(),
//       ],
//       items: [
//         PersistentBottomNavBarItem(
//           icon:  Icon(Icons.home, size: Dimensions.iconSize),
//           title: S.of(context).home,
//           activeColorPrimary: AppColors.primaryColor,
//           inactiveColorPrimary: AppColors.borderColor,
//         ),
//         PersistentBottomNavBarItem(
//           icon:  Icon(Icons.notifications, size: Dimensions.iconSize),
//           title: S.of(context).notifications,
//           activeColorPrimary: AppColors.primaryColor,
//           inactiveColorPrimary: AppColors.borderColor,
//         ),
//         PersistentBottomNavBarItem(
//
//           icon:  Icon(Icons.person, size: Dimensions.iconSize),
//           title: S.of(context).profile,
//           activeColorPrimary: AppColors.primaryColor,
//           inactiveColorPrimary: AppColors.borderColor,
//         ),
//         PersistentBottomNavBarItem(
//           icon:  Icon(Icons.settings, size: Dimensions.iconSize),
//           title: S.of(context).settings,
//           activeColorPrimary: AppColors.primaryColor,
//           inactiveColorPrimary: AppColors.borderColor,
//         ),
//       ],
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: true,
//       stateManagement: true,
//       hideNavigationBarWhenKeyboardAppears: true,
//       popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
//       backgroundColor: AppColors.secondaryColor,
//       navBarStyle: NavBarStyle.style1,
//       confineToSafeArea: true,
//     );
//   }
// }