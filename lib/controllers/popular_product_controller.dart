import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/repository/popular_product_repo.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  late CartController _cart;

  //
  //A function to call the popularProductRepo.getPopularProductList() function which returns a Response.
  //
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      //
      // If the response status code is 200, the _popularProductlist gets the json list of the Products model. This function actually feeds to the Products class in the products_model.dart file the response.body from the apiClient(), called through the popularProductsRepo.getPopularProducts() function. The Products class then works on the data and makes it available for the app to use and update the user interface via the controllers.
      //
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setCartQuantity(bool isIncrement) {
    isIncrement
        //
        //The ternary operator calls the checkQuality function and passes the current _cartQuantity with the plus or minus operator.
        //
        ? _quantity = checkQuantity(_quantity + 1)
        : _quantity = checkQuantity(_quantity - 1);
    update();
  }

//
//This function ensuers the cart counter at the bottom of the screen does not exceed 20 not fall below 0.
//
  int checkQuantity(int quantity) {
    if (_inCartItems + quantity < 0) {
      Get.snackbar('Invalid Operation', 'No items to remove',
          colorText: Colors.black87
          // backgroundColor: AppColors.mainColor, colorText: Colors.white
          );
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar('Invalid Operation', 'Exceeded available items',
          colorText: Colors.black87
          // backgroundColor: AppColors.mainColor, colorText: Colors.white
          );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProductCartQuantity(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.GetQuantity(product);
    }
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.GetQuantity(product);
    update();
    _cart.items.forEach((key, value) {
      print("Product id is: " +
          key.toString() +
          " Product quantity is: " +
          value.quantity.toString());
    });
  }
}
