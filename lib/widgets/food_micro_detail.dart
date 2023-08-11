import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class FoodMicroDetail extends StatelessWidget {
  final String text;
  const FoodMicroDetail({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) =>
                    Icon(Icons.star, color: AppColors.mainColor, size: 15),
              ),
            ),
            SizedBox(width: Dimensions.width10),
            SmallText(text: '4.5'),
            SizedBox(width: Dimensions.width20),
            SmallText(text: '1287 comments')
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: Colors.orange,
            ),
            IconAndTextWidget(
              icon: Icons.location_on_sharp,
              text: '1.7 km',
              iconColor: AppColors.mainColor,
            ),
            const IconAndTextWidget(
              icon: Icons.access_time,
              text: '32min',
              iconColor: Colors.orange,
            ),
          ],
        )
      ],
    );
  }
}
