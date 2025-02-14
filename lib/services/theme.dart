import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeModeService {
  ThemeData lightMode({required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    return ThemeData(
      scaffoldBackgroundColor: Color(0xfff1f2f2),
      fontFamily: 'SFPRODISPLAYBOLD',
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: size.width * .06,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white, size: size.height * .034),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: size.width * .042,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: size.width * .032,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  ThemeData darkMode({required BuildContext context}) {
    final size = MediaQuery.of(context).size;
    return ThemeData(
        scaffoldBackgroundColor: Color(0xff2b2c33),
        fontFamily: 'SFPRODISPLAYBOLD',
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: size.width * .06,
            fontWeight: FontWeight.bold,
          ),
          iconTheme:
              IconThemeData(color: Colors.white, size: size.height * .034),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: size.width * .042,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: size.width * .032,
              fontWeight: FontWeight.bold),
        ));
  }
}
