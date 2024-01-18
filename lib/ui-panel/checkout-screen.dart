import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:sapoapplication/controller/cart-price-controller.dart';
import 'package:sapoapplication/controller/getcustomer.dart';
import 'package:sapoapplication/utils/app-contant.dart';

import '../model/cart-model.dart';
import '../model/product-model.dart';
import '../services/place-order.dart';
class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CkeckOutScreenState();
}

class _CkeckOutScreenState extends State<CheckOutScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController = Get.put(ProductPriceController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          "Giỏ hàng",
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('giohang').doc(user!.uid)
            .collection('donhang').snapshots(),
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
            return Container(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(bottom: 60),
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                    final productData = snapshot.data!.docs[index];
                    CartModel cartModel = CartModel(
                      masp: productData['masp'],
                      maloai: productData['maloai'],
                      tensp: productData['tensp'],
                      tenloai: productData['tenloai'],
                      giamgia: productData['giamgia'],
                      gia: productData['gia'],
                      anh: productData['anh'],
                      mota: productData['mota'],
                      soluong: productData['soluong'],
                      tongtien: productData['tongtien'],
                      ngaygiao: productData['ngaygiao'],
                      valuecheckbox: productData['valuecheckbox'],
                      createdAt: productData['createdAt'],
                      updatedAt: productData['updatedAt'],
                    );

                    // tính tổng tiền sản phẩm có trong giohang
                    productPriceController.fetchProductPrice();
                    return SwipeActionCell(
                        key: ObjectKey(cartModel.masp),
                        trailingActions: [
                          SwipeAction(
                              icon: Icon(Icons.delete_outline, color: Colors.white),
                              title: "Xóa",
                              forceAlignmentToBoundary: true,
                              performsFirstActionWithFullSwipe: true,
                              onTap: (CompletionHandler handler) async {
                                print("Xóa");
                                await  FirebaseFirestore.instance.collection('giohang')
                                    .doc(user!.uid).collection('donhang').doc(cartModel.masp).delete();
                              }
                          )
                        ],
                        child: Column(
                          children: [
                            // Checkbox(
                            //     checkColor: Colors.blue,
                            //     value: cartModel.valuecheckbox,
                            //     // fillColor: MaterialStateProperty.resolveWith(getColor),
                            //     onChanged: (value) => onItemChecked(cartModel)
                            // ),
                            ListTile(
                              // leading: CircleAvatar(
                              //   backgroundColor: AppConstant.appMainColor,
                              //   backgroundImage: NetworkImage(cartModel.anh),
                              // ),
                              leading: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(cartModel.anh),
                                    )
                                ),
                              ),
                              title: Text(
                                cartModel.tensp,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("SL: ${cartModel.soluong}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₫${cartModel.tongtien}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              indent: 0,
                              endIndent: 0,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ],
                        )
                    );
                  }
              ),
            );
          }
          return Container();
        },
      ),
      bottomSheet: Container(
        color: Colors.grey,
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        // margin: EdgeInsets.only(left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Checkbox(
            //     checkColor: Colors.blue,
            //     value: allChecked.value,
            //     fillColor: MaterialStateProperty.resolveWith(getColor),
            //     onChanged: (value) => onAllChecked(allChecked)
            // ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
            //   child: Text(allChecked.title,
            //     style: TextStyle(
            //         color: Colors.white
            //     ),
            //   ),
            // ),
            Obx(()
            => Text(
              "Tổng tiền: ₫${productPriceController.totalPrice.value.toStringAsFixed(1)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstant.appScendoryColor,
              ),
              onPressed: (){
                showCustomBottomSheet();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle),
                  Text(
                    "Xác nhận",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppConstant.appTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showCustomBottomSheet(){
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: 55,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "HoTen",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: 55,
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: "SDT",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  height: 55,
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                        labelText: "DiaChi",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        hintStyle: TextStyle(
                          fontSize: 12,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstant.appMainColor,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                ),
                onPressed: () async {
                  if(nameController.text != '' && phoneController.text != '' && addressController != ''){
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String address = addressController.text.trim();

                    // String customerToken = await getCustomerDeviceToken();
                    placeOrder(
                      context: context,
                      customerName: name,
                      customerPhone: phone,
                      customerAddress: address,
                      // customerDeviceToken: customerToken,
                    );
                  }
                  else{
                    print("Vui lòng điền đầy đủ thông tin");
                  }
                },
                child: Text(
                  "Đặt hàng",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }
}
