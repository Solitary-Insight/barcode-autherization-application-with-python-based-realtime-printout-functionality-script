import 'package:barcode_auth/Features/Barcode_Creation/Screen/user_detail_page.dart';
import 'package:barcode_auth/Features/Barcode_Creation/User_model.dart';
import 'package:barcode_auth/Features/Common/Home/Controller/home_controller.dart';
import 'package:barcode_auth/firebase_options.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:barcode_auth/utils/helper/network_manger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  // Import the intl package for date formatting
import 'package:firebase_database/firebase_database.dart';

class CreateBarcodeController extends GetxController {
  final formKey = GlobalKey<FormState>(); 
    HomeController homeController=Get.isRegistered<HomeController>()?Get.find():Get.put(HomeController());

  // Observables for the form fields

  Rx<DateTime> creationDate = DateTime.now().obs;
  Rx<DateTime> creationTime = DateTime.now().obs;
  RxString name = ''.obs;
  RxString mobileNumber = ''.obs;
  Rx<DateTime> validatyDate = DateTime.now().obs;
  Rx<DateTime> validatyTime = DateTime.now().obs;

  final databaseReference = FirebaseDatabase.instance.refFromURL(DefaultFirebaseOptions.currentPlatform.databaseURL!);


  // Validation methods
  String? validateName(String value) {
    if (value.isEmpty) return 'Name is required';
    return null;
  }

  String? validateMobile(String value) {
    if (value.length != 10) return 'Enter a valid 10-digit mobile number';
    return null;
  }

  String? validateDates() {
    if (creationDate.value.isAtSameMomentAs(validatyDate.value)) {
      return 'Creation Date and Validity Date cannot be the same';
    }
    return null;
  }

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Custom validation for date comparison
      String? dateError = validateDates();
      if (dateError != null) {
        Get.snackbar('Error', dateError, colorText: Colors.red);
        return;
      }


 



      try {
        homeController.setFullScreenLoading("Saving",AppResources.SAVING_ANIMATION,"Registration is in process please wait!");
        // Create a new key in the Firebase Realtime Database
        DatabaseReference newRef = databaseReference.child(AppStrings.AUTHERIZED_USER_PARENT_NODE).push();
        String newKey = newRef.key!;

        // Format date and time strings separately
        String creationDateString = DateFormat('yyyy-MM-dd').format(creationDate.value);
        String creationTimeString = DateFormat('HH:mm:ss').format(creationTime.value);
        String validatyDateString = DateFormat('yyyy-MM-dd').format(validatyDate.value);
        String validatyTimeString = DateFormat('HH:mm:ss').format(validatyTime.value);

        // Create UserModel object
        UserModel user = UserModel(
          creation_date: creationDateString,
          expiry_date: validatyDateString,
          expiry_time: validatyTimeString,
          username: name.value,
          mobile: mobileNumber.value,
          creation_time: creationTimeString,
          key: newKey,
        );

        // Write user data to Firebase
        // Navigate to the saving_user_record activity with UserModel
         bool status = await NetworkManager.instance.isConnected();
        if (!status) {
          NetworkManager.instance.showNetworkErrorMessage();
          return;
        }
        await newRef.set({
          'creation_date': user.creation_date,
          'expiry_date': user.expiry_date,
          'expiry_time': user.expiry_time,
          'username': user.username,
          'mobile': user.mobile,
          'creation_time': user.creation_time,
          'key': user.key,
        });

        
        Get.to(() => UserRecordScreen(user: user));
        
        Get.snackbar('Successfull Registration', 'User registered successfully',backgroundColor: AppColors.success);
      } on FirebaseException catch (e) {
        // Handle specific Firebase errors
        Get.snackbar('Error', 'Firebase error: ${e.message}', colorText: Colors.red);
      } catch (e) {
        // Handle any other errors
        Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}', colorText: Colors.red);
      }
      finally{
        homeController.offFullScreenLoading();
      }
    }
  }
  
  
}



