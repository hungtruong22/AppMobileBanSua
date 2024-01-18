import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapoapplication/auth-ui/login.dart';
import 'package:sapoapplication/banner.dart';
import 'package:sapoapplication/category.dart';
import 'package:sapoapplication/custom-drawer.dart';
import 'package:sapoapplication/flashsale.dart';
import 'package:sapoapplication/ui-panel/all-product-screen.dart';
import 'package:sapoapplication/ui-panel/cart-screen.dart';
import 'package:sapoapplication/utils/app-contant.dart';
import '../all-product.dart';
import '../controller/search-controller.dart';
import '../heading.dart';
import '../ui-panel/all-flashsale-product.dart';
import '../ui-panel/seachpro-scrern.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController timkiemController = TextEditingController();
  var inputText = "";
  final SearchProController searchProController = Get.put(SearchProController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.shopping_cart)
            ),
          )
        ],
      ),
      drawer: DrawerWiget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 90,
              ),
            Container(
              height: 60,
              width: Get.width,
              margin: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Container(
                      child: TextFormField(
                        controller: timkiemController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Nhập sản phẩm cần tìm kiếm",
                            suffixIcon: Icon(Icons.search),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    10)
                            )
                        ),
                      ),
                      height: 50,
                      width: 350,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstant
                              .appScendoryColor,
                        ),
                        onPressed: () {
                            Get.to(() => SearchProScreen(inputText: timkiemController.text,));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            Text("Tìm kiếm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),
                            )
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
              //Banner
                BannerWiget(),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  color: AppConstant.appScendoryColor,
                  width: MediaQuery.sizeOf(context).width - 16,
                  height: 40,
                  child: Text(
                    "Danh mục",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appTextColor,
                    ),
                  ),
                ),
              SizedBox(
                height: 8,
              ),
                CategoriesWidget(),
              SizedBox(
                height: 8,
              ),
              // Container(
              //   padding: EdgeInsets.only(top: 10, left: 10),
              //   color: AppConstant.appScendoryColor,
              //   width: MediaQuery.sizeOf(context).width - 16,
              //   height: 40,
              //   child: Text(
              //     "Giảm giá",
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.bold,
              //       color: AppConstant.appTextColor,
              //     ),
              //   ),
              // ),
              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubTitle: "Mặt hàng đang giảm giá",
                onTap: () => Get.to(() => AllFlashSaleProductScreen()),
                buttonText: "Xem thêm >",
              ),
              SizedBox(
                height: 8,
              ),
              FlashSaleWidget(),
              SizedBox(
                height: 8,
              ),
              HeadingWidget(
                  headingTitle: "Sản phẩm có tại Shop",
                  headingSubTitle: '',
                  onTap: () => Get.to(() => AllProductsScreen()),
                  buttonText: "Xem thêm >",
              ),
              AllProductsWidget(),
            ],
          )
          ,
        ),
      ),
    );
  }
}
