import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

abstract class AppStyles {
  static TextStyle text32Bold = GoogleFonts.cairo(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.2,
  );

  static TextStyle text32SemiBold = GoogleFonts.cairo(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.2,
  );

  static TextStyle text32Regular = GoogleFonts.cairo(
    fontSize: 32.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.2,
  );

  // Font Size 28
  static TextStyle text28Bold = GoogleFonts.cairo(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.3,
  );

  static TextStyle text28SemiBold = GoogleFonts.cairo(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.3,
  );

  static TextStyle text28Regular = GoogleFonts.cairo(
    fontSize: 28.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.3,
  );

  // Font Size 25
  static TextStyle text25Bold = GoogleFonts.cairo(
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
  );

  static TextStyle text25SemiBold = GoogleFonts.cairo(
    fontSize: 25.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.3,
  );

  static TextStyle text25Regular = GoogleFonts.cairo(
    fontSize: 25.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.3,
  );

  // Font Size 24
  static TextStyle text24Bold = GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.3,
  );

  static TextStyle text24SemiBold = GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1.3,
  );

  static TextStyle text24Regular = GoogleFonts.cairo(
    fontSize: 24.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.3,
  );

  // Font Size 22
  static TextStyle text22Bold = GoogleFonts.cairo(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.3,
  );

  static TextStyle text22SemiBold = GoogleFonts.cairo(
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.3,
  );

  static TextStyle text22Regular = GoogleFonts.cairo(
    fontSize: 22.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.3,
  );

  // Font Size 21 (لأنها مستخدمة في copyWith في الـ screens)
  static TextStyle text21Bold = GoogleFonts.cairo(
    fontSize: 21.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.3,
  );

  // Font Size 20
  static TextStyle text20Bold = GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.4,
  );

  static TextStyle text20SemiBold = GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: const Color(0xffE8EBF0),
    height: 1.4,
  );

  static TextStyle text20Regular = GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.4,
  );

  static TextStyle text20Subtitle = GoogleFonts.cairo(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
    height: 1.4,
  );

  // Font Size 18
  static TextStyle text18Bold = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.4,
  );

  static TextStyle text18SemiBold = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.4,
  );

  static TextStyle text18Regular = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.4,
  );

  static TextStyle text18Button = GoogleFonts.cairo(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 28.84 / 18,
  );

  // Font Size 16
  static TextStyle text16Bold = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

  static TextStyle text16SemiBold = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.5,
  );

  static TextStyle text16Regular = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    height: 1.5,
  );

  static TextStyle text16Link = GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF4D96B9),
    height: 1.5,
  );

  // Font Size 14
  static TextStyle text14Bold = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

  static TextStyle text14SemiBold = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.5,
  );

  static TextStyle text14Regular = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[800],
    height: 1.5,
  );

  static TextStyle text14Caption = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[600],
    height: 1.5,
  );

  static TextStyle text14Error = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.red[700],
    height: 1.5,
  );

  static TextStyle text14Hint = GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[500],
    height: 1.5,
  );

  // Font Size 12
  static TextStyle text12Bold = GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

  static TextStyle text12SemiBold = GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.5,
  );

  static TextStyle text12Regular = GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[800],
    height: 1.5,
  );

  static TextStyle text12Caption = GoogleFonts.cairo(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Colors.grey[600],
    height: 1.5,
  );

  static ButtonStyle buttonStyle = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Color(0xff4D96B9), width: 2),
      borderRadius: BorderRadius.circular(50.r),
    ),
    backgroundColor: const Color(0xff4D96B9),
  );

  static ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
    backgroundColor: AppColors.secondaryColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
  );
}