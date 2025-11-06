import 'package:flutter/material.dart';
import 'package:sprint3_app/theme/colors.dart';

class CustomRefreshIndicator extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefreshIndicator({super.key, required this.onRefresh, required this.child});

  @override
  State<StatefulWidget> createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.appBarBackground,
      backgroundColor: AppColors.appBarForeground,
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
}