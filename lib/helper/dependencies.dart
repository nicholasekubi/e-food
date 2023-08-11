import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/repository/cart_repo.dart';
import 'package:food_delivery/repository/popular_product_repo.dart';
import 'package:food_delivery/repository/recommended_food_repo.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  //
  //The Get.lazyPut() func is quite helpful, do more research!!!
  //
  //
  //This must be done in this order. this entire class just ensures that the needed classes are fired up.
  //
  // ApiCLient initialization
  //
  // The apiClient takes a URL as stated in the ApiClient class. This is then used to find the Api Web Location.
  //
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // Repository initialization
  //
  //The PopularProductRepo takes the apiClient as the parameter. This is done using the Get.find from the Getx package. It finds the apiClient. Now this Get.find uses the variable type, which is the name of the class of the ApiClient (in this case) to look for the ApiClient to give to the reposiory. THe Repo can use any url for the api as needed.
  //
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  // Controller initialization
  //
  //Just like th repository, the controller also takes a particular repo as a parameter.
  //
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  // Get.lazyPut(() => CartController(cartRepo: Get.find()));
  // the code above has been replaced with the one below because:
  /*It seems like you are encountering an issue with the Flutter GetX library and the behavior of your CartController. The problem might be related to how the navigation is handled or how the CartController is being disposed of when using the in-built phone back arrow.

To help you troubleshoot the issue, here are some possible reasons and solutions:

Check if the CartController is being disposed of: When using Get.lazyPut(), the controller is created only once and kept in memory for reuse. However, if the controller is being disposed of when using the phone's back arrow, it might not be available when you navigate back to the item page. Make sure that you are not manually disposing of the CartController in your code or using any other method that could lead to its disposal.

Consider using Get.put() instead of Get.lazyPut(): Get.lazyPut() is suitable for stateless controllers that don't need to be permanently kept in memory. If your CartController is meant to persist throughout the app's lifecycle, you might want to use Get.put() instead of Get.lazyPut(). Get.put() ensures that the controller is initialized and kept alive until explicitly removed. */
  Get.put(CartController(cartRepo: Get.find()));

  //
  // THis way, there can be multiple repos and multiple controllers and multiple ApiCLients for many different reasons like calling from different API sources.
  //
}

/*// Importing the necessary controller and repository classes
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/repository/popular_product_repo.dart';
import 'package:food_delivery/repository/recommended_food_repo.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

// Defining an asynchronous function named "init"
Future<void> init() async {
  //
  // The Get.lazyPut() function is used by GetX library for dependency injection, 
  // where the provided instance is created lazily (on-demand) when it's first used.

  // Lazy initialization of the ApiClient instance with the AppConstants.BASE_URL as its base URL.
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // Lazy initialization of the PopularProductRepo instance with the ApiClient instance obtained through Get.find().
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));

  // Lazy initialization of the PopularProductController instance with the PopularProductRepo instance obtained through Get.find().
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));

  // Lazy initialization of the RecommendedProductRepo instance with the ApiClient instance obtained through Get.find().
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));

  // Lazy initialization of the RecommendedProductController instance with the RecommendedProductRepo instance obtained through Get.find().
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
}*/