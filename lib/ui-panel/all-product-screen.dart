import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:sapoapplication/ui-panel/product-detail.dart';

import '../model/product-model.dart';
import '../utils/app-contant.dart';


class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'Tất cả sản phẩm',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('sanpham')
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi!"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("Không có sản phẩm"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                    masp: snapshot.data!.docs[index]['masp'],
                    maloai: snapshot.data!.docs[index]['maloai'],
                    tensp: snapshot.data!.docs[index]['tensp'],
                    giamgia: snapshot.data!.docs[index]['giamgia'],
                    gia: snapshot.data!.docs[index]['gia'],
                    anh: snapshot.data!.docs[index]['anh'],
                    soluonghienco: snapshot.data!.docs[index]['soluonghienco'],
                    mota: snapshot.data!.docs[index]['mota'],
                  tenloai: snapshot.data!.docs[index]['tenloai'],
                    ngaygiao: snapshot.data!.docs[index]['ngaygiao']
                );

                // CategoriesModel categoriesModel = CategoriesModel(
                //   categoryId: snapshot.data!.docs[index]['categoryId'],
                //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
                //   categoryName: snapshot.data!.docs[index]['categoryName'],
                //   createdAt: snapshot.data!.docs[index]['createdAt'],
                //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
                // );
                return Row(
                  children: [
                    if(productModel.giamgia == '0')...[
                      GestureDetector(
                        onTap: () => Get.to(ProductDetailsScreen(productModel: productModel)),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            child: FillImageCard(
                              borderRadius: 20,
                              width: Get.width / 3.5,
                              heightImage: Get.height / 12,
                              imageProvider: CachedNetworkImageProvider(
                                  productModel.anh),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    productModel.tensp,
                                    style: TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              footer: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "₫${productModel.gia}",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),
                      ),
                    ]
                    else...[
                      GestureDetector(
                        onTap: () => Get.to(ProductDetailsScreen(productModel: productModel,)),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Container(
                                child: FillImageCard(
                                  borderRadius: 20,
                                  width: Get.width / 3.5,
                                  heightImage: Get.height / 12,
                                  imageProvider: CachedNetworkImageProvider(productModel.anh),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        productModel.tensp,
                                        style: TextStyle(
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  footer: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "₫${productModel.gia}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                decoration: TextDecoration.lineThrough,
                                                color: AppConstant.appScendoryColor
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "₫${productModel.gia - (productModel.gia * double.parse(productModel.giamgia)/100)}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 45,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape:BoxShape.rectangle,
                                      color: Color(0xFFffe97a),
                                      border:Border.all(color: Color(0xFFffe97a)),
                                    ),
                                    child: Text(
                                      "⚡-${productModel.giamgia}%",
                                      style: TextStyle(
                                          color: AppConstant.appScendoryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}