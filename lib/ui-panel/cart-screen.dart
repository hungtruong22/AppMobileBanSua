  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_swipe_action_cell/core/cell.dart';
  import 'package:get/get.dart';
  import 'package:image_card/image_card.dart';
  import 'package:sapoapplication/controller/cart-price-controller.dart';
import 'package:sapoapplication/ui-panel/checkout-screen.dart';
  import 'package:sapoapplication/utils/app-contant.dart';
  
  import '../model/cart-model.dart';
  import '../model/product-model.dart';
  class CartScreen extends StatefulWidget {
    const CartScreen({super.key});
  
    @override
    State<CartScreen> createState() => _CartScreenState();
  }
  
  class _CartScreenState extends State<CartScreen> {
  
    User? user = FirebaseAuth.instance.currentUser;
    final ProductPriceController productPriceController = Get.put(ProductPriceController());
    bool valueCheck= false;
    bool isChecked = false;
    final allChecked = CheckBoxModal(title: "Tất cả");
    List<CartModel> cartList = [];
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        // MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }
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
                            ),
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
                                    Row(
                                        children: <Widget>[
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppConstant.appMainColor,
                                              ),
                                              child: Text(
                                                "-",
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () async {
                                                if(cartModel.soluong > 1){
                                                  await FirebaseFirestore.instance.collection('giohang').doc(user!.uid)
                                                      .collection('donhang').doc(cartModel.masp).update({
                                                    'soluong': cartModel.soluong - 1,
                                                    'tongtien': (cartModel.giamgia != '0'
                                                        ? (cartModel.gia - (cartModel.gia * double.parse(cartModel.giamgia)/100))
                                                        : cartModel.gia) * (cartModel.soluong - 1),
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            height: 30,
                                            child: TextField(
                                              cursorColor: AppConstant.appScendoryColor,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(top: 2, left: 12),
                                                  hintText: "${cartModel.soluong}",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: AppConstant.appScendoryColor
                                                      )
                                                  )
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppConstant.appMainColor,
                                              ),
                                              child: Text(
                                                "+",
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () async {
                                                if(cartModel.soluong > 0){
                                                  await FirebaseFirestore.instance.collection('giohang').doc(user!.uid)
                                                      .collection('donhang').doc(cartModel.masp).update({
                                                    'soluong': cartModel.soluong + 1,
                                                    // 'tongtien':(cartModel.giamgia != '0'
                                                    //     ? (cartModel.gia - (cartModel.gia * double.parse(cartModel.giamgia)/100))
                                                    //     : cartModel.gia) + ((cartModel.giamgia != '0'
                                                    //     ? (cartModel.gia - (cartModel.gia * double.parse(cartModel.giamgia)/100))
                                                    //     : cartModel.gia) * (cartModel.soluong - 1)),
                                                    'tongtien': (cartModel.giamgia != '0'
                                                        ? (cartModel.gia - (cartModel.gia * double.parse(cartModel.giamgia)/100))
                                                        : cartModel.gia) * (cartModel.soluong + 1),
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ]
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
          color: Colors.black12,
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
                  Get.to(() => CheckOutScreen());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on),
                    Text(
                      "Thanh toán",
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
    late AsyncSnapshot<QuerySnapshot> snapshott;
    // hàm xử lú checkbox
    onItemChecked(CartModel cartItem){
      final newValue = !cartItem.valuecheckbox;
      setState(() {
        cartItem.valuecheckbox = newValue;

        if(!newValue){
          allChecked.value = false;
        }
        else{
          final allListChecked = cartList.every((element) => element.valuecheckbox);
          allChecked.value = allListChecked;
        }
      });
    }

    onAllChecked(CheckBoxModal ckbItem){
      final newValue = !ckbItem.value;
      setState(() {
        ckbItem.value = newValue;
        cartList.forEach((element) {
          element.valuecheckbox = newValue;
        });
      });
    }



  }
  class CheckBoxModal{
    late String title;
    late bool value;
    CheckBoxModal(
        {
          required this.title,
          this.value = false,
        }
        );
  }

