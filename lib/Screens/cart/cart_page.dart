import 'package:flutter/material.dart';
import 'package:food_delivery/Screens/home/main_food_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  var product = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios_new_rounded,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.to(MainFoodPage());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconSize24,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_checkout,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconSize24,
                  backgroundColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            right: Dimensions.width20,
            left: Dimensions.width20,
            bottom: 0,
            child: GetBuilder<CartController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.getCartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: Dimensions.height20 * 5,
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Container(
                            height: Dimensions.height20 * 5,
                            width: Dimensions.height20 * 5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(AppConstants.BASE_URL +
                                    AppConstants.UPLOAD_URL +
                                    controller.getCartItems[index].img!),
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width10),
                          Expanded(
                            child: Container(
                              height: Dimensions.height20 * 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  BigText(
                                    text: controller.getCartItems[index].name!,
                                    color: Colors.black54,
                                  ),
                                  SmallText(text: 'Spicy', maxLines: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                        text:
                                            "\$${controller.getCartItems[index].price}",
                                        color: Colors.redAccent,
                                      ),
                                      GetBuilder<PopularProductController>(
                                          builder: (productController) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions.width10,
                                              vertical: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  productController
                                                      .setCartQuantity(false);
                                                },
                                                child: Icon(Icons.remove,
                                                    color: AppColors.signColor),
                                              ),
                                              SizedBox(
                                                  width: Dimensions.width10),
                                              BigText(
                                                  text: controller
                                                      .getCartItems[index]
                                                      .quantity
                                                      .toString()),
                                              SizedBox(
                                                  width: Dimensions.width10),
                                              GestureDetector(
                                                onTap: () {
                                                  productController
                                                      .setCartQuantity(true);
                                                },
                                                child: Icon(Icons.add,
                                                    color: AppColors.signColor),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
