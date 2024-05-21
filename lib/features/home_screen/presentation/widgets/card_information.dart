import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/spacing.dart';
import '../../../../../core/theming/styles.dart';
class CardInformation extends StatelessWidget {
  final String name, image;

  const CardInformation({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.mainWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 50.r,
                   height: 50.r,

                  child: Image.network(image)),
              horizontalSpacing(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name, style: TextStyles.font12BlackBold),
                  verticalSpacing(10),
                ],
              ),
            ],
          ),
          horizontalSpacing(10), // Add horizontal spacing

        ],
      ),
    );
  }
}
