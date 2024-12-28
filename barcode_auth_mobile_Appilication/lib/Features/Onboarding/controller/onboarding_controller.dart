import 'package:barcode_auth/Features/Common/Home/Controller/home_controller.dart';
import 'package:barcode_auth/Features/Common/Home/Screen/Home.dart';
import 'package:barcode_auth/Features/Onboarding/screen/onboarding_screen.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  final device_storage = GetStorage();

  @override
  void onReady() {
    // super.onReady();  // Ensure that the parent's `onReady` method is called
    screen_direct(); // Call your screen navigation logic
  }

  void complete_Onboard() {
    device_storage.writeIfNull(AppStrings.ONBOARDING_STORAGE_KEY, true);
    screen_direct();
  }

  void screen_direct() {
    // Ensure the storage is initialized and set the default value if not set

    bool? isFirstTime =
        device_storage.read(AppStrings.ONBOARDING_STORAGE_KEY);

    if (isFirstTime == true) {
  Get.isRegistered<HomeController>()?null:Get.put(HomeController());

      Get.offAll(() => const Home());

      print("Home");
    } else {
      Get.offAll(() => const OnboardingScreen());
      print("Onboarding");
    }
  }
}
