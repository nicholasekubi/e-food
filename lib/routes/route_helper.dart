import 'package:food_delivery/Screens/food/popular_food_detail.dart';
import 'package:food_delivery/Screens/food/recommended_food_detail.dart';
import 'package:food_delivery/Screens/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String popularFood = '/Popular-Food';
  static const String recommendedFood = '/Recommended-Food';

  //
  //Functions are better to use here cuz the caller can send the index of the page to be created which can then be used to render theh correct food details from the resouces gotten from the server.
  //

  static String getInitial() => '$initial';
  static String getPopularFood(pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(pageId) => '$recommendedFood?pageId=$pageId';

  //
  //The List of routes is fed to the getRoutes param in the main.dart file. The param just holds all the pages to be navigated.
  //
  //
  //The routes here return the functions created above. Now because the functions are called, the
  //

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.native),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!));
        })
  ];
}
