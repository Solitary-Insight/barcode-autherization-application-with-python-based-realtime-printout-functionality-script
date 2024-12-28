
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class curvedContainer extends StatelessWidget {
  final double radius;

  final Widget child;

  const curvedContainer({super.key, required this.radius, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
        child: child);
  }
}