import 'package:get/get.dart';

class Dimensions {
  List Numbers = [817, 384];

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

// pageView carousel dimensions
  static double pageViewContainer = screenHeight / 3.7136363636;
  static double pageViewTextContiner = screenHeight / 6.80833;
  static double pageView = screenHeight / 2.8172413793;

// heights
  static double height10 = screenHeight / 81.7066666;
  static double height20 = screenHeight / 40.85;
  static double height15 = screenHeight / 54.4666666667;
  static double height30 = screenHeight / 27.23333333;
  static double height45 = screenHeight / 18.155555556;

// widths
  static double width5 = screenWidth / 76.8;
  static double width10 = screenWidth / 34.8;
  static double width20 = screenWidth / 17.4;
  static double width15 = screenWidth / 23.2;
  static double width30 = screenWidth / 11.6;
  static double width45 = screenWidth / 8.53333333;

// font sizes
  static double font20 = screenHeight / 40.85;
  static double font26 = screenHeight / 31.423;
  static double font16 = screenHeight / 51.0625;

//Radiuses size
  static double radius15 = screenHeight / 54.46667;
  static double radius20 = screenHeight / 40.85;
  static double radius30 = screenHeight / 27.233333;

// icon sizes
  static double iconSize24 = screenHeight / 34.0416666;
  static double iconSize16 = screenHeight / 51.0625;

// listView size
  static double listViewImgSizeHeight = screenHeight / 6.8083333;
  static double listViewTextContainerHeight = screenHeight / 8.17;
  static double listViewImgWidth = screenWidth / 3.2;
  static double listViewTextContainerWidth = screenWidth / 1.92;

  // Popular foods detail
  static double popularFoodDetailImgSize = screenHeight / 2.334;
}
