import 'package:barcode_auth/Features/Barcode_Creation/Screen/user_detail_page.dart';
import 'package:barcode_auth/Features/Barcode_Creation/User_model.dart';
import 'package:barcode_auth/Features/Common/Home/Controller/home_controller.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:barcode_auth/utils/helper/network_manger.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeScannerController extends GetxController {
  Rx<String> barcode_reading = "".obs;
  RxBool isAuthenticating = false.obs;
  BarcodeScannerController get _instance => Get.find();

  void ScanBarCode() async {
    try {
      // Show full-screen loading during user authentication

      // Scan barcode
      barcode_reading.value = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      if (barcode_reading.value != '-1') {
        bool status = await NetworkManager.instance.isConnected();
        if (!status) {
          NetworkManager.instance.showNetworkErrorMessage();
          return;
        }
        // Retrieve user data from Firebase using the scanned barcode as the key
        final userRef = FirebaseDatabase.instance
            .ref()
            .child(AppStrings.AUTHERIZED_USER_PARENT_NODE)
            .child(barcode_reading.value);
        HomeController.instance.setFullScreenLoading(
            "User Authentication",
            AppResources.AUTHENTICATING_BARCODE_ANIMATION,
            "User is being authenticated, please wait!");
        userRef.once().then((DatabaseEvent event) {
          if (event.snapshot.exists) {
            // Create UserModel from the Firebase snapshot
            final userData = UserModel.fromSnapshot(
                Map<String, dynamic>.from(event.snapshot.value as Map),
                barcode_reading.value);

            // Navigate to SavingUserRecord with the retrieved user data
            Get.to(() => UserRecordScreen(
                  user: userData,
                  show_verification_bar: true,
                ));
            HomeController.instance.offFullScreenLoading();
          } else {
            Get.snackbar("User not found", "No user found with this barcode.",
                backgroundColor: AppColors.error);
            HomeController.instance.offFullScreenLoading();

            // Handle case where user is not found
          }
        }).catchError((error) {
          print("Error retrieving user data: $error");
          Get.snackbar("Error getting data ",
              "Can not get user data at the time. try Again.",
              backgroundColor: AppColors.error);
          HomeController.instance.offFullScreenLoading();
        });
      } else {
        Get.snackbar("Action Cancelled", "Barcode scanning was cancelled.",
            backgroundColor: AppColors.error);
        HomeController.instance.offFullScreenLoading();
      }
    } finally {
      // Dismiss loading after the process is complete
    }
  }
}
