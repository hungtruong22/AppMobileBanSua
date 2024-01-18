import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchProController extends GetxController {
  var inputText = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String ten) async {
    final QuerySnapshot prodData =
    await _firestore.collection('sanpham').where('tensp', isEqualTo: ten).get();
    return prodData.docs;
  }
}