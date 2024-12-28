import 'package:barcode_auth/App.dart';
import 'package:barcode_auth/Features/Onboarding/controller/onboarding_controller.dart';
import 'package:barcode_auth/firebase_options.dart';
import 'package:barcode_auth/utils/helper/network_manger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


// ...


void main() async {
  // Ensure that widget binding is initialized
  //  final WidgetsBinding widgetsBinding =
  //     WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize GetStorage before injecting any dependencies

  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  Get.put(NetworkManager());

  Get.put(OnboardingController());
  // Now inject the OnboardingController  Q1s

  // Run the application
  runApp(const App());
}
