import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sapoapplication/auth-ui/login.dart';
import 'package:sapoapplication/auth-ui/signup.dart';
import 'package:sapoapplication/auth-ui/splash-screen.dart';
import 'package:sapoapplication/ui-panel/profile.dart';
import 'package:sapoapplication/ui-panel/thongtin.dart';
import 'package:sapoapplication/user/main-screen.dart';

void main() async{
  // var myApp = new MyApp();
  // runApp(myApp);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "sapo-web-con",
    options: FirebaseOptions(
        apiKey: "AIzaSyBOuSND2g3bYKRMG1CXrdzd3Zp_rSe6HxQ",
        appId: "1:301060984115:web:adbe35d7bb3bdc7e2b0246",
        messagingSenderId: "301060984115",
        projectId: "sapoapp-886f3"
    )
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {// hàm này có tác dụng ta ra dao diện
    return GetMaterialApp(
      title: "HC-Milks",
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      //   theme: ThemeData(
      //   fontFamily: 'RobotoIta',
      // ),
      routes: {
        "home" : (context) => MainScreen(),
        "login" : (context) => LoginApp(),
        "signup" : (context) => SignUpApp(),
      },
    );
  }
}