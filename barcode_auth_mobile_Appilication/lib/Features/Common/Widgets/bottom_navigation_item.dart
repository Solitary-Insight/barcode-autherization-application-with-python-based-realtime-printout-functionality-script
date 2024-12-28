
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class navigation_item extends StatelessWidget {
  final Color bgcolor;
  final Color color;
  final int fontweight;
  final double iconSize;
  final String label;
  final double padding;
  final IconData icon;
  final VoidCallback? onTap;
  final bool showShadow;

  const navigation_item({
    super.key,
    required this.bgcolor,
    required this.color,
    this.fontweight = 600,
    required this.label,
    this.padding = AppSizes.sm,
    required this.icon,
    this.iconSize = 18, this.onTap, required this.showShadow,

  });

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: showShadow?[
                BoxShadow(
                  color: AppColors.primaryBackground.withOpacity(0.5), // Shadow color
                  spreadRadius:1, // Spread radius
                  blurRadius: 2, // Blur radius
                  offset: const Offset(1, 1), // Shadow offset (x, y)
                ),
              ]:null ,
            // color: AppColors.accent,
            borderRadius: const BorderRadius.all(Radius.circular(AppSizes.cardRadiusLg))
          ),
          margin: const EdgeInsets.all(AppSizes.sm),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: iconSize,
                ),
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.apply(color: color, fontWeightDelta: fontweight),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}