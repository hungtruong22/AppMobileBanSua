import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:sapoapplication/ui-panel/product-detail.dart';
import '../model/product-model.dart';
import '../utils/app-contant.dart';
class SearchProScreen extends StatefulWidget {
  String inputText;
   SearchProScreen({super.key, required this.inputText});

  @override
  State<SearchProScreen> createState() => _SearchProScreenState();
}

class _SearchProScreenState extends State<SearchProScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Sản phẩm cần tìm'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('sanpham')
            // .where('tensp', isEqualTo: widget.inputText)
            .orderBy("tensp")
            .startAt([widget.inputText])
            .endAt([widget.inputText + '\uf8ff'])
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
              child: Text("Không tìm thấy sản phẩm."),
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

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(ProductDetailsScreen(productModel: productModel,)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 20.0,
                            width: Get.width / 4,
                            heightImage: Get.height / 10,
                            imageProvider: CachedNetworkImageProvider(
                              productModel.anh,
                            ),
                            title: Text(
                              productModel.tensp  ,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.0),
                            ),

                            footer: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "₫${productModel.gia}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppConstant.appScendoryColor
                                      ),
                                    ),
                                    Text(
                                      "SL: ${productModel.soluonghienco}",
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
