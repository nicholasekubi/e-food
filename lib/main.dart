import 'package:flutter/material.dart';
import 'package:food_delivery/Screens/home/main_food_page.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  //
  //WidgetsFlutterBinding.ensureInitialized(); This ensures that the Getx network dependencies (dependencies.dart file) are initilaized.
  //
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    //The purpose of calling Get.find<PopularProductController>().getPopularProductList() inside the build method of the MyApp widget is to ensure that the list of popular products is fetched and available before the rest of the application renders. This approach may have been chosen to fetch necessary data and ensure it is ready for use in other parts of the application. Next time use this statement inside the initState() rather than the build method for performance issues.
    //
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainFoodPage(),
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
