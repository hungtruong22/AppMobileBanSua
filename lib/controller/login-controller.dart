import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapoapplication/model/user-model.dart';
import 'package:sapoapplication/utils/app-contant.dart';
class LoginController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // hiển thị passwork
  var isPasswordVisible = true.obs;
  Future<UserCredential?> LoginMethod(
      String userEmail,
      String userPassword,
      ) async{
    try{
      // EasyLoading.show(status: "Vui lòng chờ");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      // EasyLoading.dismiss();
      return userCredential;
    }
    on FirebaseAuthException catch(e){
      Get.snackbar(
        "Error",
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appScendoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}