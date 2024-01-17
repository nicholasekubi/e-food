import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height20 + 15, bottom: Dimensions.height20),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text: 'Nigeria', color: AppColors.mainColor),
                    Row(
                      children: [
                        SmallText(
                          text: 'State',
                          color: Colors.black,
                          maxLines: 1,
                        ),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    ),
                  ],
                ),
                /*Search icon*/
                Container(
                  height: Dimensions.height45,
                  width: Dimensions.width45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                  child: Icon(Icons.search_rounded,
                      color: Colors.white, size: Dimensions.iconSize24),
                ),
              ],
            ),
          ),
          // Carousel body
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
