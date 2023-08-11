import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/food_micro_detail.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    //Now here the var product is used to hold and instance of the popularProductList from the Get.find of the PopularProductList in the PopularProductController with the particular index (pageId).
    //
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    //
    //THis ensures that the every product detail page has a cart quantity set to zero.
    //
    Get.find<PopularProductController>()
        .initProductCartQuantity(Get.find<CartController>());
    //print('Got pageID = ' + pageId.toString());
    //print('Product name = ' + product.name);
    return Scaffold(
      backgroundColor: Colors.white,
      // The stack is used because the details portion of this page overlaps the image.
      body: Stack(
        children: [
          // Food Image
          //
          //THis Positioned widget allows the image to be paced in anyplace
          //
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodDetailImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      product.img!),
                ),
              ),
            ),
          ),

          //Icon Buttons
          //
          //This Positioned widget inserts the Icons over the FoodImage
          //
          Positioned(
            // The
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios_new_rounded)),
                GestureDetector(
                    onTap: () {},
                    child: AppIcon(icon: Icons.shopping_cart_outlined))
              ],
            ),
          ),
          // Food Details Panel
          //
          //This Positioned widget makes the places the Food Details panel over the Food Image.
          //
          Positioned(
            left: 0,
            right: 0,
            // The bottom param stretches the container to the bottom of the page, because by default the container will want to only take the space needed by the child of that container.
            bottom: 0,
            // subtracting the 20 is not neccessarily because of the Dimensions.radius20 for the container radius. It is just to bring up the Food Details panel above the Food Image
            top: Dimensions.popularFoodDetailImgSize - 60,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodMicroDetail(text: product.name),
                  SizedBox(height: Dimensions.height20 / 4),
                  BigText(text: 'Introduce'),
                  SizedBox(height: Dimensions.height20 / 4),
                  ExpandableTextWidget(text: product.description),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.height10 * 9,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10, vertical: Dimensions.width5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                    topLeft: Radius.circular(Dimensions.radius20 * 2)),
                color: AppColors.buttonBackgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //
                // Add and Remove Button with counter
                //
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => popularProduct.setCartQuantity(false),
                          child:
                              Icon(Icons.remove, color: AppColors.signColor)),
                      SizedBox(width: Dimensions.width10),
                      BigText(text: popularProduct.cartQuantity.toString()),
                      SizedBox(width: Dimensions.width10),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setCartQuantity(true);
                          },
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                //
                // Add to cart button and price
                //
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width20,
                      vertical: Dimensions.height20),
                  child: GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: BigText(
                        text: '\$${product.price} | Add to cart',
                        color: Colors.white,
                        size: Dimensions.font20),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
