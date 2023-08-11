import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/api/api_client.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});
//
//function to call the apiClient which gets data from the server. The apiCLient function returns to the getPopularProductList() function a Response. The getPopularProductList() function gives the apiCLient() function a url.
//
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
