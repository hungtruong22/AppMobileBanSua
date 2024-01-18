import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapoapplication/auth-ui/login.dart';
import 'package:sapoapplication/ui-panel/all-orderscreen.dart';
import 'package:sapoapplication/ui-panel/profile.dart';
import 'package:sapoapplication/user/main-screen.dart';
import 'package:sapoapplication/utils/app-contant.dart';

import 'controller/getuserdata-controller.dart';
import 'model/user-model.dart';
class DrawerWiget extends StatefulWidget {
  const DrawerWiget({super.key});

  @override
  State<DrawerWiget> createState() => _DrawerWigetState();
}

class _DrawerWigetState extends State<DrawerWiget> {
  User? user = FirebaseAuth.instance.currentUser;
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());
  Future<String> getUsername() async {
    List<QueryDocumentSnapshot<Object?>> userData = await getUserDataController.getUserData(user!.uid);
    if (userData.isNotEmpty) {
      UserModel userModel = UserModel.fromMap(userData[0].data() as Map<String, dynamic>);
      return userModel.username;
    } else {
      throw Exception('No user found with this uId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        // padding: EdgeInsets.only(top: Get.height/25),
        padding: EdgeInsets.only(top: 6),
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Wrap(
            runSpacing: 10,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').where('uId', isEqualTo: user!.uid).get(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userData = snapshot.data!.docs[0];

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text(
                            userData['username'],
                            style: TextStyle(
                                color: AppConstant.appTextColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(
                            "${userData['isAdmin'] == true ? "Admin" : "User"}",
                            style: TextStyle(
                              color: AppConstant.appTextColor,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: AppConstant.appMainColor,
                            backgroundImage:
                            NetworkImage(userData['userImg']),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),

              Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1.5,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Trang chủ",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                    ),
                  ),
                  leading: Icon(Icons.home, color: AppConstant.appTextColor),
                  onTap: (){
                    Get.to(() => MainScreen());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Sản phẩm",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                    ),
                  ),
                  leading: Icon(Icons.production_quantity_limits, color: AppConstant.appTextColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Đơn hàng",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                    ),
                  ),
                  leading: Icon(Icons.list_alt_outlined, color: AppConstant.appTextColor,),
                  onTap: (){
                    Get.back();
                    Get.to(() => AllOrdersScreen());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Thông tin cá nhân",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                    ),
                  ),
                  leading: Icon(Icons.person, color: AppConstant.appTextColor,),
                  onTap: (){
                    Get.to(() => ProfileScreen());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListTile(
                  onTap: () async {
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.signOut();
                    Get.offAll(() => LoginApp());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Đăng xuất",
                    style: TextStyle(
                      color: AppConstant.appTextColor,
                    ),
                  ),
                  leading: Icon(Icons.logout, color: AppConstant.appTextColor),
                ),
              ),
            ],
          ),
          backgroundColor: AppConstant.appMainColor,
        ),
    );
  }
}
