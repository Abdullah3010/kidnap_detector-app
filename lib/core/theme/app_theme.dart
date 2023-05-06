import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: offWhiteColor,
        primaryColor: primaryColor,
        fontFamily: 'Tajawal',
        appBarTheme: const AppBarTheme(
          backgroundColor: whiteColor,
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            Theme.of(context).textTheme.labelLarge,
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.transparent,
          ),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.labelLarge),
            backgroundColor: MaterialStateProperty.all(
              primaryColor,
            ),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24.sp,
            color: boldGreyColor,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22.sp,
            color: blackColor,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.sp,
            color: blackColor,
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 19.sp,
            color: blackColor,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16.sp,
            color: boldGreyColor,
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: mediumBlackColor,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: blackColor,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: boldGreyColor,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: blackColor,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: mediumBlackColor,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 22.sp,
            color: whiteColor,
          ),
          titleMedium: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: blackColor,
          ),
          titleSmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: mediumBlackColor,
          ),
          labelSmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: dimGreyColor,
          ),
        ),
      );
}

const Color primaryColor = Color(0xffE57A7A);
const Color blueColor = Color(0xff0072A6);
const Color blackColor = Color(0xff000000);
const Color lightBlackColor = Color(0xff455574);
const Color whiteColor = Color(0xffFFFFFF);
const Color offWhiteColor = Color(0xffF7F7F7);
const Color greenColor = Color(0xff008F1D);
const Color lightGreenColor = Color(0xff00AF8E);
const Color darkGreyColor = Color(0xff706F6F);
const Color lightBlueColor = Color(0xffE7F9FA);
const Color orangeColor = Color(0xffD97400);
const Color darkYellow = Color(0xff9B8B00);
const Color lightGreyColor = Color(0xffEBF1E9);
const Color darkGreenColor = Color(0xff1B6A64);
const Color pinkColor = Color(0xffC56C8C);
const Color brownColor = Color(0xffF5EEE6);
const Color yellowColor = Color(0xff9B8B00);
const Color veryLightGreenColor = Color(0xffD9F7EA);
const Color lightOffWhiteColor = Color(0xffF2FBF9);
const Color lightBeigeColor = Color(0xffFFF3F3);
const Color darkPinkColor = Color(0xffC56C8B);
const Color greyColor = Color(0xff707070);
const Color greyLightColor = Color(0xffAAA4A2);
const Color lightWhiteColor = Color(0xffF6F7EB);
const Color boldGreyColor = Color(0xff443F3F);
const Color redColor = Color(0xffFF5050);
const Color veryLightGreyColor = Color(0xffEFEFEF);
const Color mediumGreyColor = Color(0xffF7F7F7);
const Color veryLightOffWhiteColor = Color(0xffFCFCFC);
const Color mediumGreenColor = Color(0xff49B800);
const Color lightBrownColor = Color(0xffBF9300);
const Color lightPinkColor = Color(0xffE57A7A);
const Color mediumBlackColor = Color(0xff2B1B17);
const Color whiteSmokeColor = Color(0xFFf2f2f2);
const Color greySmokeColor = Color(0xFFCBCBCB);
const Color dimGreyColor = Color(0xFF666666);
const Color whisperGreyColor = Color(0xFFEDEDED);
const Color grey90Color = Color(0xFFE5E5E5);
const Color darkBlueColor = Color(0xFF0031A5);
const Color veryDarkGreenColor = Color(0xFF00720F);
const Color lightYellowColor = Color(0xFFC7B300);
const Color veryDarkPinkColor = Color(0xFFF37173);
const Color veryGreenPinkColor = Color(0xFF00C7AC);
const Color lightSmokeGreyColor = Color(0xFFFAFAFA);
const Color dimBlueColor = Color(0xFF020F54);
const Color darkRedColor = Color(0xffFF5C5C);
const Color lightMediumGreyColor = Color(0xff989898);
const Color lightMediumGreenColor = Color(0xff07B900);
const Color veryLightMediumGreenColor = Color(0xffE5FFFC);
const Color lightMediumRedColor = Color(0xffFEF9F9);
const Color veryLightMediumGreyColor = Color(0xffF3F3F3);
const Color veryLightMediumPinkColor = Color(0xffFFF0F0);
const Color veryLightPinkColor = Color(0xffFAF5F5);
const Color lightGoldColor = Color(0xffD1B959);
const Color cartFreeBannerBG = Color(0xffE56464);
// const Color veryLightGreenColor = Color(0xffD1B959);
