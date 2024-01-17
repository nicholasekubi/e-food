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
            SmallText(
              text: '4.5',
              maxLines: 1,
            ),
            SizedBox(width: Dimensions.width20),
            Expanded(
              child: SmallText(
                text: '1287 comments',
                maxLines: 1,
              ),
            )
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconAndTextWidget(
                icon: Icons.circle_sharp,
                size: Dimensions.font20,
                text: 'Normal',
                iconColor: Colors.orange,
              ),
            ),
            Expanded(
              child: IconAndTextWidget(
                icon: Icons.location_on_sharp,
                size: Dimensions.font20,
                text: '1.7 km',
                iconColor: AppColors.mainColor,
              ),
            ),
            Expanded(
              child: IconAndTextWidget(
                icon: Icons.access_time,
                size: Dimensions.font20,
                text: '32 min',
                iconColor: Colors.orange,
              ),
            ),
          ],
        )
      ],
    );
  }
}
