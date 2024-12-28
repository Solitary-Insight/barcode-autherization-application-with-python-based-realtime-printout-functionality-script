import 'package:barcode_auth/Features/Barcode_Creation/Screen/progress_page.dart';
import 'package:barcode_auth/Features/Common/Home/Controller/home_controller.dart';
import 'package:barcode_auth/Features/Common/Widgets/bottom_navigation_item.dart';
import 'package:barcode_auth/Features/Common/Widgets/curved_container.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:barcode_auth/utils/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller=Get.isRegistered<HomeController>()?Get.find():Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(elevation: 2,shadowColor: AppColors.darkerGrey, backgroundColor: AppColors.primary,centerTitle:true,title: const Text("Barcode Authentication"),),

      backgroundColor: AppColors.primary,
      body: Obx(()=>controller.full_screen_loading.value?controller.progress_overlay.value: Container(
        child: Column(
          children: [
          Expanded(child: Obx(()=>controller.pages[controller.current_page_index.value])),
            curvedContainer(
                radius: AppSizes.lg,
                child: Obx(()=>Row(
                  children: [
                    navigation_item(
                      onTap: (){
                        controller.updatepage(0);
                      },
                      bgcolor: Colors.black12,
                      fontweight: controller.current_page_index.value==0?800:400,
                      // iconSize: controller.current_page_index.value==0?20:16,

                      icon: Iconsax.barcode,
                      label: "Create",
                      showShadow: controller.current_page_index.value==0,

                      color: controller.current_page_index.value!=0?AppColors.darkerGrey:AppColors.primary,
                    ),
                    navigation_item(
                      onTap: (){
                        controller.updatepage(1);
                      },
                      icon: Iconsax.scan,
                      fontweight: controller.current_page_index.value==1?800:400,
                      // iconSize: controller.current_page_index.value==1?26:20,
                      iconSize: 26,
                      label: "Scan",
                      showShadow: controller.current_page_index.value==1,

                      bgcolor: AppColors.white,
                      color: controller.current_page_index.value!=1?AppColors.darkerGrey:AppColors.primary,
                    ),
                    navigation_item(
                      onTap: (){
                        controller.updatepage(2);
                      },
                      // iconSize: controller.current_page_index.value==2?20:16,
                      fontweight: controller.current_page_index.value==2?800:400,
                      icon: Iconsax.clock,
                      label: "History",
                      bgcolor: AppColors.white,
                      showShadow: controller.current_page_index.value==2,
                      color: controller.current_page_index.value!=2?AppColors.darkerGrey:AppColors.primary,
                    ),
                  ],
                )))
          ],
        ),
      )),
     
    );
  }
}

