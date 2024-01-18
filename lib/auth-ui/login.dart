import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sapoapplication/admin/adminmain-screen.dart';
import 'package:sapoapplication/controller/login-controller.dart';
import 'package:sapoapplication/user/main-screen.dart';
import 'package:sapoapplication/utils/app-contant.dart';

import '../controller/getuserdata-controller.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp>{
  final LoginController loginController = Get.put(LoginController());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppConstant.appScendoryColor,
            title: Text(
              "Welcome to HC-Milks",
              style: TextStyle(
                color: AppConstant.appTextColor,
              ),
            ),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isKeyboardVisible ? Text("Welcome to HC-Milks Shop")
                :Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 250,
                      color: AppConstant.appScendoryColor,
                      child: Lottie.asset("assest/lotie1.json"),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Đăng Nhập",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: Icon(Icons.email),
                        contentPadding: EdgeInsets.only(top: 2, left: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      controller: userEmail,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Obx(
                        () => TextFormField(
                          cursorColor: AppConstant.appScendoryColor,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    loginController.isPasswordVisible.toggle();
                                  },
                                  child: loginController.isPasswordVisible.value
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)
                              ),
                              contentPadding: EdgeInsets.only(top: 2, left: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          controller: userPassword,
                          obscureText: loginController.isPasswordVisible.value,
                        ),
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Text(
                      "Quên mật khẩu ?",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstant.appScendoryColor,
                        fontWeight: FontWeight.bold),
                      ),
                  ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppConstant.appScendoryColor,
                      ),

                      child: TextButton(
                        onPressed: () async{
                          String email = userEmail.text.trim();
                          String password = userPassword.text.trim();
                          if(email.isEmpty || password.isEmpty){
                            Get.snackbar(
                              "Lỗi!",
                              "Vui lòng nhập đầy đủ thông tin.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                          else{
                            UserCredential? userCredential =await loginController.LoginMethod(
                                email,
                                password
                            );
                            var userData = await getUserDataController.getUserData(userCredential!.user!.uid);
                            if(userCredential != null){
                              if(userCredential.user!.emailVerified){
                                if(userData[0]['isAdmin'] == true){
                                  Get.snackbar(
                                    "Thành Công",
                                    "Đăng nhập Admin thành công",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppConstant.appScendoryColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                  Get.offAll(() => AdminMainScreen());
                                }else{
                                  Get.snackbar(
                                    "Thành Công",
                                    "Đăng nhập User thành công",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppConstant.appScendoryColor,
                                    colorText: AppConstant.appTextColor,
                                  );
                                  Get.offAll(() => MainScreen());
                                }
                              }
                              else{
                                Get.snackbar(
                                  "Lỗi!",
                                  "Vui lòng xác minh email trước khi đăng nhập",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appScendoryColor,
                                  colorText: AppConstant.appTextColor,

                                );
                              }
                            }
                            else{
                              Get.snackbar(
                                "Lỗi!",
                                "Vui lòng đăng nhập thử lại"
                              );
                            }
                          }
                        },
                        child:  Text(
                            "Đăng nhập",
                            style: TextStyle(
                              color: AppConstant.appTextColor,
                            ),
                          ),
                        // child: InkWell(
                        //   onTap: (){
                        //     Navigator.pushNamed(context, "home");
                        //   },
                        //   child:  Text(
                        //     "Đăng nhập",
                        //     style: TextStyle(
                        //       color: AppConstant.appTextColor,
                        //     ),
                        //   ),
                        // ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                          "Nếu bạn chưa có tài khoản?"
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(4, 10, 0, 0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "signup");
                        },
                        child: Text(
                          "Hãy đăng ký tại đây!",
                          style: TextStyle(
                            color: AppConstant.appScendoryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
