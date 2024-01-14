import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final double size;

  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,
      this.size = 22})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.context!.width;
    // if (screenWidth >= 320) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: size),
        SizedBox(width: Dimensions.width5),
        Expanded(
          child: SmallText(
            text: text,
            maxLines: 1,
          ),
        ),
        // screenWidth >= 400
        //     ? SmallText(text: text)
        //     : SmallText(text: '${text.substring(0, 3)}' + '...'),
      ],
    );

    // the if function here was implemented to ensure that the check does not overflow. This checks the length and subs the string and concactinates an ellipsis at the end of the text.
    // } else {
    //   return Row(
    //     children: [
    //       Icon(icon, color: iconColor),
    //       SizedBox(width: Dimensions.width5),
    //       SmallText(
    //         text: text.length >= 5 ? '${text.substring(0, 3)}' + '...' : text,
    //       ),
    //     ],
    //   );
  }
}
