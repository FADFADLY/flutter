import 'package:flutter/material.dart';

/// A class containing color constants used across the Flutter app.
class AppColors {
  static const Color primaryColor = Color(0xff295163); // لون أساسي داكن (أزرق غامق)
  static const Color secondaryColor = Color(0xff4D96B9); // لون ثانوي (أزرق فاتح)
  static const Color backgroundColor = Color(0xffE8EBF0); // لون خلفية فاتح
  static const Color borderColor = Colors.grey; // لون حدود رمادي
  static const Color errorColor = Color(0xffF44336); // لون أحمر للأخطاء
  static const Color whiteColor = Colors.white; // أبيض نقي
  static const Color textColor = Color(0xff000000); // أسود نقي للنصوص
  static const Color successColor = Color(0xff4CAF50); // لون أخضر للنجاح

  // ألوان إضافية مستخدمة في التحسينات
  static const Color blackColor = Color(0xFF000000); // أسود نقي
  static const Color greyLightColor = Color(0xFFD3D3D3); // رمادي فاتح للخلفيات الثانوية
  static const Color greyColor = Color(0xFF808080); // رمادي متوسط للنصوص وأيقونات

  // تدرجات ألوان مستخدمة
  static const Color secondaryColorLight = Color(0x804D96B9); // secondaryColor مع opacity 0.5 (للتدرج)
  static const Color greyLightShadow = Color(0x0D808080); // greyColor مع opacity 0.05 (للظلال)
  static const Color greyMediumShadow = Color(0x19808080); // greyColor مع opacity 0.1 (للظلال)
}