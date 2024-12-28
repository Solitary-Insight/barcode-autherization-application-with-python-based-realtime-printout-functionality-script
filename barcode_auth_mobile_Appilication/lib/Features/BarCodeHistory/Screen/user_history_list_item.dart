import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_auth/Features/BarCodeHistory/Controller/barcode_history_controller.dart';
import 'package:barcode_auth/Features/Barcode_Creation/Screen/user_detail_page.dart';
import 'package:barcode_auth/Features/Barcode_Creation/User_model.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class History_user_list_items extends StatelessWidget {
  const History_user_list_items({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
          color: UserModel.checkVerificationValidation(user)
              ? AppColors.success.withOpacity(0.9)
              : AppColors.error.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.md))),
      child: ListTile(
          title: Text(
            user.username,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Registration Date & Time",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          Text(user.creation_date,
                              style: Theme.of(context).textTheme.labelSmall),
                          const SizedBox(width: AppSizes.spaceBtwItems),
                          Text(user.creation_time,
                              style: Theme.of(context).textTheme.labelSmall)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Expiry Date & Time",
                          style: Theme.of(context).textTheme.bodyLarge),
                      Row(
                        children: [
                          Text(user.expiry_date,
                              style: Theme.of(context).textTheme.labelSmall),
                          const SizedBox(width: AppSizes.spaceBtwItems),
                          Text(user.expiry_time,
                              style: Theme.of(context).textTheme.labelSmall)
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'Confirm record deletion!',
                      desc:
                          'User record will be deleted permenently. continue?',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        handlUserDeletion(user, context);
                      },
                    ).show();
                  },
                  icon: const Icon(Iconsax.box_remove)),
              const SizedBox(
                width: AppSizes.sm,
              ),
              TextButton(
                  onPressed: () {
                    Get.to(() => UserRecordScreen(
                          user: user,
                          show_verification_bar: true,
                        ));
                  },
                  child: const Text("See Detail"))
            ],
          )),
    );
  }

  void handlUserDeletion(UserModel user, BuildContext context) async {
    try {
      await BarcodeHistoryController.instance.deleteUserRecord(user.key ?? "");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Deleted!',
        desc: "User record has been deleted.",
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error deleting record',
        desc: e.toString(),
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }
}
