import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sapoapplication/model/cart-model.dart';
import 'package:sapoapplication/model/product-model.dart';
import 'package:sapoapplication/utils/app-contant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'cart-screen.dart';
class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
    ProductDetailsScreen ({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Chi tiết sản phẩm"),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            // ảnh sản phẩm
            Container(
              child: CachedNetworkImage(
                imageUrl: widget.productModel.anh,
                fit: BoxFit.cover,
                width: Get.width - 10,
                height: Get.height / 2.2,
                placeholder: (context, url) => ColoredBox(
                  color: Colors.white,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),

                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            if(widget.productModel.giamgia == '0')...[
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productModel.tensp,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "SL: ${widget.productModel.soluonghienco}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "₫${widget.productModel.gia}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mô tả sản phẩm:",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: RatingBar.builder(
                          minRating: 1,
                          itemSize: 14,
                          itemBuilder: (context,_) => Icon(Icons.star,color: Color(0xFFffb61c),),
                          onRatingUpdate: (rating){},
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productModel.mota,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
            else...[
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.sizeOf(context).width,
                      color: AppConstant.appScendoryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "⚡Flash Sale",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppConstant.appTextColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productModel.tensp,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "SL: ${widget.productModel.soluonghienco}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 4),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "₫${widget.productModel.gia}",
                              style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppConstant.appScendoryColor
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "₫${widget.productModel.gia - (widget.productModel.gia * double.parse(widget.productModel.giamgia)/100)}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Mô tả sản phẩm:",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: RatingBar.builder(
                          minRating: 1,
                          itemSize: 14,
                          itemBuilder: (context,_) => Icon(Icons.star,color: Color(0xFFffb61c),),
                          onRatingUpdate: (rating){},
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.productModel.mota,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey,
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width / 2.1,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appScendoryColor,
                  ),
                  onPressed: () async {
                    await checkProductExistence(uId: user!.uid);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_shopping_cart_rounded),
                      Text(
                        "Thêm vào giỏ hàng",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppConstant.appTextColor,
                        ),
                      ),
                    ],

                  ),

              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width / 2.1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.appScendoryColor,
                ),
                onPressed: (){

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on),
                    Text(
                      "Mua sản phẩm",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstant.appTextColor,
                      ),
                    ),
                  ],

                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  // kiểm tra sản phẩm có tồn tại hay không
  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async{
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('giohang').doc(uId)
        .collection('donhang').doc(widget.productModel.masp.toString());

    DocumentSnapshot snapshot = await documentReference.get();
    if(snapshot.exists){
      int currentQuantity = snapshot['soluong'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double tongtien = (widget.productModel.giamgia != '0'
          ? (widget.productModel.gia - (widget.productModel.gia * double.parse(widget.productModel.giamgia)/100))
          : widget.productModel.gia) * updatedQuantity;

      await documentReference.update({
        'soluong' : updatedQuantity,
        'tongtien' : tongtien,
      });
      print("sản phẩm có tồn tại");
    }
    else{
      await FirebaseFirestore.instance.collection('giohang').doc(uId).set({
        'uId' : uId,
        'createdAt' : DateTime.now(),
      });

      CartModel cartModel = CartModel(
          masp: widget.productModel.masp,
          maloai: widget.productModel.maloai,
          tensp: widget.productModel.tensp,
          tenloai: widget.productModel.tenloai,
          giamgia: widget.productModel.giamgia,
          gia: widget.productModel.gia,
          anh: widget.productModel.anh,
          mota: widget.productModel.mota,
          soluong: 1,
          tongtien: widget.productModel.giamgia != '0'
              ? (widget.productModel.gia - (widget.productModel.gia * double.parse(widget.productModel.giamgia)/100))
              : widget.productModel.gia,
          ngaygiao: widget.productModel.ngaygiao,
          valuecheckbox: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
      );
      await documentReference.set(cartModel.toMap());
      print("đã thêm sản phẩm");
    }
  }

}
