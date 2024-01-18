import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart-price-controller.dart';
import '../model/order-model.dart';
import '../utils/app-contant.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
  Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text('Tất cả đơn hàng'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
            .snapshots(),
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
              child: Text("Không tìm thấy sản phẩm"),
            );
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    masp: productData['masp'],
                    maloai: productData['maloai'],
                    tensp: productData['tensp'],
                    tenloai: productData['tenloai'],
                    giamgia: productData['giamgia'],
                    gia: productData['gia'],
                    anh: productData['anh'],
                    ngaygiao: productData['ngaygiao'],
                    mota: productData['mota'],
                    createdAt: DateTime.now(),
                    updatedAt: productData['updatedAt'],
                    soluong: productData['soluong'],
                    tongtien: double.parse(productData['tongtien'].toString()),
                    makh: productData['makh'],
                    trangthai: productData['trangthai'],
                    hotenkh: productData['hotenkh'],
                    sdtkh: productData['sdtkh'],
                    diachikh: productData['diachikh'],
                  );

                  //calculate price
                  productPriceController.fetchProductPrice();
                  return Card(
                    elevation: 5,
                    color: AppConstant.appTextColor,
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(orderModel.anh),
                            )
                        ),
                      ),
                      title: Text(
                        orderModel.tensp,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text("SL: ${orderModel.soluong}"),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("₫${orderModel.tongtien}"),
                              SizedBox(
                                width: 10.0,
                              ),
                              orderModel.trangthai != true
                                  ? Text(
                                "Đang chờ xác nhận..",
                                style: TextStyle(color: Colors.green),
                              )
                                  : Text(
                                "Đã xác nhân.",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}