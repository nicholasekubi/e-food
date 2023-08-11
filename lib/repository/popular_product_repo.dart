import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:food_delivery/data/api/api_client.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});
//
//function to call the apiClient which gets data from the server. The apiCLient function returns to the getPopularProductList() function a Response. The getPopularProductList() function gives the apiCLient() function a url.
//
  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
