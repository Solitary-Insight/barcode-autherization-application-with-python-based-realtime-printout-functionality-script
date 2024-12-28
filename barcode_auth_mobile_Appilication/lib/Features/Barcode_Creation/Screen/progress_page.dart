
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressPage extends StatelessWidget {
  final String heading;
  
  final String bottom;
  
  final String animation;

  const ProgressPage({super.key, required this.heading, required this.bottom, required  this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,height: 400,width: 400),
          const SizedBox(height: AppSizes.spaceBtwItems)
          ,Text(bottom,style: Theme.of(context).textTheme.titleMedium,)
        ],
      ),
    );
  }
}