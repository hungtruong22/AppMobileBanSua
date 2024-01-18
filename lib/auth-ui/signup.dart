import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sapoapplication/auth-ui/login.dart';
import 'package:sapoapplication/controller/singup-controller.dart';
import 'package:sapoapplication/utils/app-contant.dart';

class SignUpApp extends StatefulWidget {
  const SignUpApp({super.key});

  @override
  State<SignUpApp > createState() => _SignUpAppState();
}
class _SignUpAppState extends State<SignUpApp>{
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userRePassword = TextEditingController();
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
                        height: 120,
                        color: AppConstant.appScendoryColor,
                        child: Lottie.asset("assest/lotie1.json"),
                      ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Đăng Ký",
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
                    child: TextFormField(
                      cursorColor: AppConstant.appScendoryColor,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "UserName",
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      controller: userName,
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      controller: userPhone,
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
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                          hintText: "City",
                          prefixIcon: Icon(Icons.place),
                          contentPadding: EdgeInsets.only(top: 2, left: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      controller: userCity,
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
                                      signUpController.isPasswordVisible.toggle();
                                    },
                                      child: signUpController.isPasswordVisible.value
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility)
                                  ),
                                  contentPadding: EdgeInsets.only(top: 2, left: 8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              controller: userPassword,
                              obscureText: signUpController.isPasswordVisible.value,
                            ),
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
                              hintText: "Re-Password",
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                  onTap: (){
                                    signUpController.isRePasswordVisible.toggle();
                                  },
                                  child: signUpController.isRePasswordVisible.value
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility)
                              ),
                              contentPadding: EdgeInsets.only(top: 2, left: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                          controller: userRePassword,
                          obscureText: signUpController.isRePasswordVisible.value,
                        ),
                    )
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
                        onPressed: () async {
                          String name = userName.text.trim();
                          String email = userEmail.text.trim();
                          String phone = userPhone.text.trim();
                          String city = userCity.text.trim();
                          String password = userPassword.text.trim();
                          String repassword = userRePassword.text.trim();
                          String userDeviceToken = '';
                          if(name.isEmpty || email.isEmpty || phone.isEmpty
                              || city.isEmpty || password.isEmpty || repassword.isEmpty
                          ){
                            Get.snackbar(
                              "Lỗi!",
                              "Vui lòng nhập đầy đủ thông tin.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appScendoryColor,
                              colorText: AppConstant.appTextColor,
                            );
                          }
                          else{
                            if(repassword == password){
                              UserCredential? userCredential = await signUpController.signUpMethod(
                                name,
                                email,
                                phone,
                                city,
                                password,
                                userDeviceToken,
                              );
                              if(userCredential != null){
                                print("người dùng:  ${userCredential} ô tô kê nha");
                                Get.snackbar(
                                  "Đã gửi email xác minh.",
                                  "Vui lòng kiểm tra email của bạn.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appScendoryColor,
                                  colorText: AppConstant.appTextColor,
                                );
                                FirebaseAuth.instance.signOut();
                                Get.offAll(() => LoginApp());
                              }
                            }
                            else{
                              Get.snackbar(
                                "Lỗi!",
                                "Mật khâu nhập lại không trùng khớp với mật khẩu đã nhập.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appScendoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                            }
                          }
                        },
                        child:  Text(
                            "Đăng Ký",
                            style: TextStyle(
                              color: AppConstant.appTextColor,
                            ),
                          ),
                        // child: InkWell(
                        //   onTap: (){
                        //     Navigator.pushNamed(context, "home");
                        //   },
                        //   child:  Text(
                        //     "Đăng Ký",
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
                      margin: EdgeInsets.fromLTRB(4, 10, 0, 0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "login");
                        },
                        child: Text(
                          "Quay lại đăng nhập",
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
