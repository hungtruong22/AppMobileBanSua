import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapoapplication/ui-panel/all-orderscreen.dart';
import '../controller/getuserdata-controller.dart';
import '../utils/app-contant.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  User? user = FirebaseAuth.instance.currentUser;
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(color: AppConstant.appTextColor),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').where('uId', isEqualTo: user!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userData = snapshot.data!.docs[0];
                  return Container(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(userData['userImg']),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Điều chỉnh giá trị sigmaX và sigmaY tùy ý
                              child: Container(
                                width: Get.width,
                                height: 200,
                                color: Colors.transparent,
                              ),
                            ),
                            Container(
                              width: Get.width,
                              height: 300,
                              color: Colors.black12,
                            ),
                            Positioned(
                              top: 150,
                              left: Get.width/3.5,
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(userData['userImg']),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            userData['username'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          margin: EdgeInsets.only(left: 50),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          width: 50,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: AppConstant.appScendoryColor,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 1),
                                            child: Text(
                                                "${userData['isAdmin'] == true ? "Admin" : "User"}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "${userData['city']}, Việt Nam",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(left: 0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black12,
                          height: 350,
                          padding: EdgeInsets.fromLTRB(40, 0, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Card(
                                  color: AppConstant.appScendoryColor,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Họ Tên:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.white
                                              ),
                                            ),
                                            Text(
                                              userData['username'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "SDT:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white
                                                )
                                            ),
                                            Text(
                                              userData['phone'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Địa Chỉ:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white
                                                )
                                            ),
                                            Text(
                                              userData['city'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Quyền:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white
                                                )
                                            ),
                                            Text(
                                              "${userData['isAdmin'] == true ? "Admin" : "User"}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                width: 240,
                                margin: EdgeInsets.fromLTRB(0, 0, 22, 0),
                              ),
                              Container(
                                width: 180,
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 130,
                                      child: ElevatedButton(
                                        onPressed: (){

                                        },
                                        child: Column(
                                          children: [
                                            Icon(Icons.edit),
                                            Text("Chỉnh Sửa")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 130,
                                      child: ElevatedButton(
                                        onPressed: (){

                                        },
                                        child: Column(
                                          children: [
                                            Icon(Icons.password),
                                            Text("Đổi Mật Khẩu")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 130,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Get.to(() => AllOrdersScreen());
                                        },
                                        child: Column(
                                          children: [
                                            Icon(Icons.list_alt_rounded),
                                            Text("Đơn Hàng")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }
          }
      )
    );
  }
}
