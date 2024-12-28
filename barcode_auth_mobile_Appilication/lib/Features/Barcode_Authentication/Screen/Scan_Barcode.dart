import 'package:barcode_auth/Features/Barcode_Authentication/controller/barcode_scanner_controller.dart';
import 'package:barcode_auth/Features/Common/Home/Controller/home_controller.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ScanBarcode extends StatelessWidget {
   ScanBarcode({super.key});
  final BarcodeScannerController controller =
        Get.isRegistered<BarcodeScannerController>()
            ? Get.find()
            : Get.put(BarcodeScannerController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  "BAR CODE SCANNING",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .apply(fontWeightDelta: 600),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                Lottie.asset(AppResources.SCANNING_BARCODE_ANIMATION,
                    height: 400),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                Text(
                  "Place user barcode in front of camera to  validate user.",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(fontWeightDelta: 600),
                ),
                const SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.ScanBarCode();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8,
                    foregroundColor: AppColors.dark,
                    shadowColor: Colors.black.withOpacity(0.5),
                  ),

                  child: Text('Scan Now'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}

void Get_User_Data({required String key}) {
}
