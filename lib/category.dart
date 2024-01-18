import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:sapoapplication/model/category-model.dart';
import 'package:sapoapplication/ui-panel/productbycate.dart';
class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('loaisanpham').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Lỗi!"),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if(snapshot.data!.docs.isEmpty){
            return Center(
              child: Text("Không tìm thấy danh mục"),
            );
          }
          if(snapshot.data != null){
            return Container(
              height: Get.height / 5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    CategoryModel categoryModel = CategoryModel(
                        maloai: snapshot.data!.docs[index]['maloai'],
                        anh: snapshot.data!.docs[index]['anh'],
                        tenloai: snapshot.data!.docs[index]['tenloai']);
                    return Row(
                      children: [

                        GestureDetector(
                          onTap: () => Get.to(() => AllSingleCategoryProductsScreen(
                              categoryId: categoryModel.maloai),),
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                child: FillImageCard(
                                  borderRadius: 20,
                                  width: Get.width / 4,
                                  heightImage: Get.height / 12,
                                  imageProvider: CachedNetworkImageProvider(categoryModel.anh),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        categoryModel.tenloai,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                ),
                                  // footer: Text(""),
                                ),
                              ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
            );
          }
          return Container();
        }
    );
  }
}
