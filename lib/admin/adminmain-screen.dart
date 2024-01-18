import 'package:flutter/material.dart';
class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen ({super.key});

  @override
  State<AdminMainScreen> createState() => _State();
}

class _State extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin HC-Milks"),
      ),
    );
  }
}
