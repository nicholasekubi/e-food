import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_food_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/food_micro_detail.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController myPageContoller = PageController(viewportFraction: 0.85);

  var _currentPageValue = 0.0;
  double scaleFactor = 0.8;

  @override
  void initState() {
    super.initState();
    myPageContoller.addListener(() {
      setState(() {
        _currentPageValue = myPageContoller.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    myPageContoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('height is' + MediaQuery.of(context).size.height.toString());
    print('Width is' + MediaQuery.of(context).size.width.toString());
    // this container must have a height. all containers that have a child that does not contain a default height must have a heoght specified. This or else error.
    return Column(
      children: [
        //
        //Always wrap the most relevant senior widget of what you want the server to update with the GetBuilder<>(builder:(){return (widgeToBuild)}). In this case we are updating the carousel with images and other information gotten from the server.
        //
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  //
                  // the pageview.builder returns a function that creates each individual page using a stack widget with multiple containers layered on.
                  //
                  // Carousel section.
                  child: PageView.builder(
                      controller: myPageContoller,
                      //
                      //Call the controller(popularProducts).List generated by controller from the model(popularProductList).property of list(length) or specific list memeber.
                      //
                      itemCount: popularProducts.popularProductList.isEmpty
                          ? 1
                          : popularProducts.popularProductList.length,
                      itemBuilder: (context, index) {
                        return _buildPageItem(
                            index, popularProducts.popularProductList[index]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        //Dots for pageview Carousel
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        //
        // Recommended foods section
        //
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommeded'),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(text: '.', color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: SmallText(text: 'Food Pairing'),
              ),
            ],
          ),
        ),

        //
        //Recommended food list area
        //
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProduct) {
            return recommendedProduct.isLoaded
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // The shrinkWrap parameter allows one to use a ListView without needing to wrap it inside a container with a bounded height.
                    shrinkWrap: true,
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getRecommendedFood(index));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height10),
                          child: Row(
                            //THis Row widget holds the Images on the left of the List View and the Text associated on the right of the list view.
                            children: [
                              //
                              // Image Section of the list
                              //
                              Container(
                                width: Dimensions.listViewImgWidth,
                                height: Dimensions.listViewImgSizeHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white30,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              recommendedProduct
                                                  .recommendedProductList[index]
                                                  .img!),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              //
                              // Text Section of the list
                              //
                              Expanded(
                                child: Container(
                                  height:
                                      Dimensions.listViewTextContainerHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(height: Dimensions.height10),
                                        SmallText(
                                            text:
                                                'With Chinese Characteristics'),
                                        SizedBox(height: Dimensions.height10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              size: 20,
                                              text: 'Normal',
                                              iconColor: Colors.orange,
                                            ),
                                            IconAndTextWidget(
                                              icon: Icons.location_on_sharp,
                                              size: 20,
                                              text: '1.7 km',
                                              iconColor: AppColors.mainColor,
                                            ),
                                            const IconAndTextWidget(
                                              icon: Icons.access_time,
                                              size: 20,
                                              text: '32min',
                                              iconColor: Colors.orange,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  );
          },
        )
      ],
    );
  }

  // Sliding carousel function.
  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 myMatrix = Matrix4.identity();
// This if else block asseses the pages to change the scale using the myMatrix variable.
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - scaleFactor);
      myMatrix = Matrix4.diagonal3Values(1, currScale, 1);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (_currentPageValue - index + 1) * (1 - scaleFactor);
      myMatrix = Matrix4.diagonal3Values(1, currScale, 1);
    } else {
      var currScale = scaleFactor;
      myMatrix = Matrix4.diagonal3Values(1, currScale, 1);
    }

    return Transform(
      transform: myMatrix,
      // the alignment porperty, ensures the carousel is always centered. Most especially the ones on the left and right of the one being viewed.
      alignment: Alignment.center,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xff69c5df) : Color(0xff9294cc),
                image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          //Smaller box beneath the main food image on the pageview
          Align(
            // the Align widget auto positions the child widget in the center of the parent widget. The alignment property then specifies where exactly the child should be placed.
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContiner,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                  // BoxShadow(color: Colors.white),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: FoodMicroDetail(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
