import 'package:flutter/material.dart';
import 'package:qatjobs/core/styles/color_name_style.dart';

class PullToRefreshWidget extends StatelessWidget {
  const PullToRefreshWidget({
    super.key,
    required this.onRefresh,
    required this.child,
  });
  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.warning,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
