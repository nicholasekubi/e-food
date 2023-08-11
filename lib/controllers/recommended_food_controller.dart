import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/repository/recommended_food_repo.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  //
  //A function to call the popularProductRepo.getPopularProductList() function which returns a Response.
  //
  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      //
      // If the response status code is 200, the _popularProductlist gets the json list of the Products model. This function actually feeds to the Products class in the products_model.dart file the response.body from the apiClient(), called through the popularProductsRepo.getPopularProducts() function. The Products class then works on the data and makes it available for the app to use and update the user interface via the controllers.
      //
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      //print(popularProductList);
      update();
    } else {
      print('recommended products error controller');
    }
  }
}
