import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled2/models/Product.dart';

class ProductApi{
  const ProductApi();
  Stream<List<Product>> getProduct(){
    final ref=FirebaseFirestore.instance.collection('Product');

    return ref.snapshots().map((event) {
      final p=<Product>[];
      for(var doc in event.docs ){
        final product=Product.fromJson(doc.data());
        p.add(product);
      }
      return p;
    });
}


}