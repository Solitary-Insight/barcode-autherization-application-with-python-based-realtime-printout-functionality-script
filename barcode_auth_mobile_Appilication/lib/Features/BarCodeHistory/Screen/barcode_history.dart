import 'package:barcode_auth/Features/BarCodeHistory/Controller/barcode_history_controller.dart';
import 'package:barcode_auth/Features/BarCodeHistory/Screen/user_history_list_item.dart';
import 'package:barcode_auth/Features/Barcode_Creation/Screen/progress_page.dart';
import 'package:barcode_auth/Features/Barcode_Creation/User_model.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeHistory extends StatelessWidget {
  BarcodeHistory({super.key});
  BarcodeHistoryController controller =
      Get.isRegistered<BarcodeHistoryController>()
          ? Get.find()
          : Get.put(BarcodeHistoryController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Container(
        color: AppColors.primary,
        child: Obx(() {
          return controller.are_user_loading.value != "DONE"
              ? Center(
                  child: Column(
                    children: [
                      Text(controller.are_user_loading.value),
                      ProgressPage(
                          heading: "Processing",
                          bottom: "Looks like you are not connected to internet!",
                          animation: AppResources.NETWORK_ERROR_ANIMATION),
                    ],
                  ))
              : ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (_, index) {
                    UserModel user = controller.users[index];
                    return History_user_list_items(user: user);
                  },
                );
        }),
      )),
    );
  }
}
