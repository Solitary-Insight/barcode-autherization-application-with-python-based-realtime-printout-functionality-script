import 'package:barcode_auth/Features/Common/Home/Screen/Home.dart';
import 'package:barcode_auth/Features/Onboarding/controller/onboarding_controller.dart';
import 'package:barcode_auth/Features/Onboarding/screen/onboarding_screen.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:barcode_auth/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.APP_NAME,
      themeMode: ThemeMode.system,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding:null,
      home: const Scaffold(
            backgroundColor: AppColors.primary,
            body:CircularProgressIndicator(color: AppColors.white,),
      ));
  
  }
}