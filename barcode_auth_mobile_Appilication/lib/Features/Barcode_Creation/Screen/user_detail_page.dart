import 'dart:typed_data';

import 'package:barcode_auth/Features/Barcode_Creation/User_model.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:widgets_to_image/widgets_to_image.dart'; // For formatting dates

class UserRecordScreen extends StatelessWidget {
  final UserModel user;
  
  bool show_verification_bar=false;

  UserRecordScreen({required this.user,this.show_verification_bar=false, super.key});
// WidgetsToImageController to access widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          shadowColor: AppColors.darkerGrey,
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: const Text("Barcode Authentication"),
        ),
        body: Container(
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.sm),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "Authenticated user",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(fontWeightDelta: 800),
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  barcodePreview(
                    id: user.key ?? "",
                  ),
                  const SizedBox(
                    height: AppSizes.sm,
                  ),
                  Row(
                    children: [
                      const Icon(Iconsax.personalcard),
                      const SizedBox(
                        width: AppSizes.spaceBtwItems,
                      ),
                      Text(
                        "User information",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(fontWeightDelta: 800),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(AppSizes.sm))),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            profile_item(
                              field_name: "Name",
                              icon: Iconsax.user,
                              field_value: user.username,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.all(AppSizes.sm),

                            //   child:  UserModel.checkVerificationValidation(user)
                            //         ? Container(child: Text("Verified"),color: AppColors.success,)
                            //         : Container(child: Text("Declined"),color: AppColors.error),
                            //   ),
                           show_verification_bar? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(AppSizes.sm),
                                    decoration: BoxDecoration(
                                        color: UserModel
                                                .checkVerificationValidation(
                                                    user)
                                            ? AppColors.success
                                            : AppColors.error,
                                       ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.sm,
                                          vertical: AppSizes.sm),
                                      child: Text(
                                        UserModel.checkVerificationValidation(
                                                user)
                                            ? "Verified"
                                            : "Declined",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ):Container(),

                            Row(
                              children: [
                                Expanded(
                                  child: profile_item(
                                    field_name: "Creation Date ",
                                    icon: Iconsax.calendar,
                                    field_value: user.creation_date,
                                  ),
                                ),
                                Expanded(
                                  child: profile_item(
                                    field_name: "Time",
                                    icon: Iconsax.clock,
                                    field_value: user.creation_time,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: profile_item(
                                    field_name: "Expiry Date ",
                                    icon: Iconsax.calendar,
                                    field_value: user.expiry_date,
                                  ),
                                ),
                                Expanded(
                                  child: profile_item(
                                    field_name: "Time",
                                    icon: Iconsax.clock,
                                    field_value: user.expiry_time,
                                  ),
                                ),
                              ],
                            ),
                            profile_item(
                              field_name: "User key",
                              icon: Iconsax.key,
                              field_value: user.key ?? "",
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class barcodePreview extends StatelessWidget {
  const barcodePreview({
    super.key,
    this.id = '',
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.sm))),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sm),
        child: BarcodeWidget(
          barcode: Barcode.code128(),
          color: AppColors.black,
          data: id ?? "",
          drawText: false,
          errorBuilder: (context, error) => Center(child: Text(error)),
        ),
      ),
    );
  }
}

class profile_item extends StatelessWidget {
  final String field_name;

  final IconData? icon;

  final String field_value;

  const profile_item({
    super.key,
    required this.field_name,
    this.icon,
    required this.field_value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field_name,
                style: const TextStyle(
                    color: AppColors.dark, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: AppSizes.sm,
              ),
              Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.black,
                    size: 22,
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                  Text(
                    field_value,
                    style: const TextStyle(
                        color: AppColors.dark, fontWeight: FontWeight.w800),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
