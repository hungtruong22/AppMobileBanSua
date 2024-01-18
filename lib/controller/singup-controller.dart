import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sapoapplication/model/user-model.dart';
import 'package:sapoapplication/utils/app-contant.dart';
class SignUpController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // hiển thị passwork
  var isPasswordVisible = true.obs;
  var isRePasswordVisible = true.obs;
  Future<UserCredential?> signUpMethod(
      String userName,
      String userEmail,
      String userPhone,
      String userCity,
      String userPassword,
      String userDeviceToken,
      ) async{
        try{
          // EasyLoading.show(status: "Vui lòng chờ");
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
              email: userEmail,
              password: userPassword,
          );

          // gửi email xác minh (send email verification)
          await userCredential.user!.sendEmailVerification();

          UserModel userModel = UserModel(
            uId: userCredential.user!.uid,
            username: userName,
            email: userEmail,
            phone: userPhone,
            userImg: '',
            userDeviceToken: userDeviceToken,
            country: '',
            userAddress: '',
            street: '',
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
            city: userCity,
          );

          // thêm dữ liệu vào CSDL
          _firestore.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());
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