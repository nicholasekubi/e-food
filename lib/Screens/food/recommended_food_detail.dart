import 'package:flutter/material.dart';
import 'package:food_delivery/Screens/cart/cart_page.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  //
  //you can use final here and then add const to the constructor.
  //
  int pageId;
  RecommendedFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<RecommendedProductController>()
        .initProductCartQuantity(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          //
          // The SliverAppBar allows for the appbar to expand and unexpand when scrolled, like the samsung appBar.
          //
          SliverAppBar(
            automaticallyImplyLeading: false,
            //
            // The tittle porperty places the button and text to be displayed in the appbar. Here it takes a Row as a child to use multiple icons.
            //
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.close(1);
                      //Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<RecommendedProductController>(
                  builder: ((controller) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              CartPage(),
                            );
                          },
                          child:
                              const AppIcon(icon: Icons.shopping_cart_checkout),
                        ),
                        Get.find<RecommendedProductController>().totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: Stack(
                                  children: [
                                    AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor,
                                    ),
                                    Get.find<RecommendedProductController>()
                                                .totalItems >=
                                            1
                                        ? Positioned(
                                            right: 3,
                                            top: 1,
                                            child: BigText(
                                              text: Get.find<
                                                      RecommendedProductController>()
                                                  .totalItems
                                                  .toString(),
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    );
                  }),
                ),
              ],
            ),
            //
            //The toolbar height ensures visibility for the title. It does not allow the title to be scrolled beyond view
            //
            toolbarHeight: 70,
            //
            // Pinned property ensures that the appbar does not disapper completely when scrolled
            //
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            //
            // The expnadedHeight property limits the max height of the AppBar
            //
            expandedHeight: 300,
            //
            //The flexibleSpace property takes a FLexibleSpaceBar widget and uses a background property to set what will be in the appBar. In this case we have an Image. It usually dictates what will happen to the SliverAppBar properties as it is scrolled.
            //
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            //
            //The bottom property takes a PreferredSize Widget that determines the max scrolled up height of the appBar
            //
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              //
              //The Recommended Food Name
              //
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                ),
                child: Center(
                  child: BigText(text: product.name, size: Dimensions.font26),
                ),
              ),
            ),
          ),
          //
          //The Bottom Text detail for the Recommended Food
          //
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableTextWidget(text: product.description),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<RecommendedProductController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            //
            //mainAxisSize ensures the column takes as little space as the children need.
            //
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              // First row of the bottomNavBar. The add and remove button.
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: (() {
                      controller.setCartQuantity(false);
                    }),
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  Container(
                    child: BigText(
                      text: '\$${product.price} X ${controller.inCartItems}',
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      controller.setCartQuantity(true);
                    }),
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                ],
              ),
              //
              // Favourites Button and Add to cart Button
              //
              Container(
                height: Dimensions.height10 * 9,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.width5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20 * 2),
                        topLeft: Radius.circular(Dimensions.radius20 * 2)),
                    color: AppColors.buttonBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    //Favourites Button
                    //
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    //
                    // Add to cart button and price
                    //
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height20),
                        child: BigText(
                            text:
                                '\$${product.price * controller.inCartItems} | Add to cart',
                            color: Colors.white,
                            size: Dimensions.font20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
