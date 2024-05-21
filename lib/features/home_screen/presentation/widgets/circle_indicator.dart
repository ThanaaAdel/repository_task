import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
class CircleIndicator extends StatelessWidget {
  const CircleIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorsManager.mainColor,
      ),
    );
  }
}