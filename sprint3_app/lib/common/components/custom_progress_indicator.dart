import 'package:flutter/material.dart';
import 'package:sprint3_app/common/theme/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.tertiary,
      backgroundColor: AppColors.appBarBackground,
    );
  }
}