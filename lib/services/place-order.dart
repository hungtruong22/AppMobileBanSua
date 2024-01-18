import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../model/order-model.dart';
import '../user/main-screen.dart';
import '../utils/app-contant.dart';
import 'genrate-order-id-service.dart';


void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  // required String customerDeviceToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  // EasyLoading.show(status: "Please Wait..");
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('giohang')
          .doc(user.uid)
          .collection('donhang')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel cartModel = OrderModel(
          masp: data['masp'],
          maloai: data['maloai'],
          tensp: data['tensp'],
          tenloai: data['tenloai'],
          giamgia: data['giamgia'],
          gia: data['gia'],
          anh: data['anh'],
          ngaygiao: data['ngaygiao'],
          mota: data['mota'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          soluong: data['soluong'],
          tongtien: double.parse(data['tongtien'].toString()),
          makh: user.uid,
          trangthai: false,
          hotenkh: customerName,
          sdtkh: customerPhone,
          diachikh: customerAddress,
          // customerDeviceToken: customerDeviceToken,
        );

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set(
            {
              'uId': user.uid,
              'hotenkh': customerName,
              'sdtkh': customerPhone,
              'diachikh': customerAddress,
              // 'customerDeviceToken': customerDeviceToken,
              'trangthaidathang': false,
              'createdAt': DateTime.now()
            },
          );

          //upload orders
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confirmOrders')
              .doc(orderId)
              .set(cartModel.toMap());

          //delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(cartModel.masp.toString())
              .delete()
              .then((value) {
            print('Delete cart Products $cartModel.productId.toString()');
          });
        }
      }

      print("Order Confirmed");
      Get.snackbar(
        "Đặt hàng thành công",
        "Cảm ơn bạn vì đã tin tưởng sản phẩm của HC-Milks",
        backgroundColor: AppConstant.appMainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );

      EasyLoading.dismiss();
      Get.offAll(() => MainScreen());
    } catch (e) {
      print("Lỗi $e");
    }
  }
}