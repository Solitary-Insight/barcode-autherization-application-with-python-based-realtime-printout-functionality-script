import 'package:barcode_auth/Features/Common/Widgets/curved_container.dart';
import 'package:barcode_auth/Features/Onboarding/controller/onboarding_controller.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
     OnboardingController controller=Get.isRegistered<OnboardingController>()?Get.find():Get.put(OnboardingController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(elevation: 2,shadowColor: AppColors.darkerGrey, backgroundColor: AppColors.primary,centerTitle:true,title: const Text(""),),

      body: Padding(
        padding: const EdgeInsets.only(top: AppSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Bar Code Authentication",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.apply(color: AppColors.white, fontWeightDelta: 700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            Expanded(
              flex: 2,
              child: Lottie.asset(
                AppResources.ONBOARDING_ANIMATION,
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
                child: curvedContainer(
              radius: AppSizes.lg,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Scan , Authenticate and explore",
                        style: Theme.of(context).textTheme.bodyLarge?.apply(
                            color: const Color.fromARGB(255, 1, 80, 25),
                            fontWeightDelta: 800),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwItems,
                    ),
                    Text(
                      "A quick and effective way of identification",
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: const Color.fromARGB(255, 1, 80, 25),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: AppSizes.spaceBtwItems,
                    ),
                    Flexible(
                      child: Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.sm),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.complete_Onboard();
                                },
                                child: const Text("Go to app")),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

