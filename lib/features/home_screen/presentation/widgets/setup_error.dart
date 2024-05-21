import 'package:flutter/material.dart';

import '../../../../core/theming/styles.dart';
setupErrorState(BuildContext context, String error) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(
        error,
        style: TextStyles.font14MediumLightBlack,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Got It',
            style: TextStyles.font20BoldBlack,
          ),
        ),
      ],
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 32,
      ),
    ),
  );
}