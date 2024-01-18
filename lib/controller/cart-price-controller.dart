import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductPriceController extends GetxController{
  RxDouble totalPrice = 0.0.obs;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void onInit(){
    fetchProductPrice();
    super.onInit();
  }

  void fetchProductPrice()async{
    final QuerySnapshot<Map<String, dynamic>> snapshot
    = await FirebaseFirestore.instance.collection('giohang').doc(user!.uid)
    .collection('donhang').get();

    double sum = 0;
    for(final doc in snapshot.docs){
      final data = doc.data();
      if(data != null && data.containsKey('tongtien')){
        sum += (data['tongtien'] as num).toDouble();
      }
    }
    totalPrice.value = sum;
  }
}