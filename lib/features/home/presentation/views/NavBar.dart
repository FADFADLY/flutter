import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/home/presentation/views/home_view.dart';
import 'package:graduationproject/features/profile/domain/repo/repo.dart';
import 'package:graduationproject/features/profile/presentation/controller/cubit/profile_cubit.dart';
import 'package:graduationproject/features/profile/presentation/view/profile_view.dart';
import '../../../../../core/helper_func/on_generate_route.dart';
import '../../../notifications/presentation/views/notification_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const routeName = '/bottomNavBar';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // قايمة الصفحات
  static final List<Widget> _screens = [
    const HomeView(),
    NotificationView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        profileRepo: getIt<ProfileRepo>(),
      )..getProfile(),
      child: Scaffold(
        body: _screens[_selectedIndex], // عرض الصفحة بناءً على الـ index
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: Dimensions.iconSize,
                  color: _selectedIndex == 0 ? AppColors.primaryColor : Colors.white,
                ),
                label: S.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.bell_solid,
                  size: Dimensions.iconSize,
                  color: _selectedIndex == 1 ? AppColors.primaryColor : Colors.white,
                ),
                label: S.of(context).notifications,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person,
                  size: Dimensions.iconSize,
                  color: _selectedIndex == 2 ? AppColors.primaryColor : Colors.white,
                ),
                label: S.of(context).profile,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.white,
            backgroundColor: Colors.transparent, // عشان نستخدم الـ Container decoration
            elevation: 0, // إزالة الـ elevation الافتراضي
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.white,
            ),
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }
}