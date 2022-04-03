import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/domin/ProductState.dart';
import 'package:untitled2/models/Product.dart';

class DataProductCubit extends Cubit<DataProductState>{
  DataProductCubit( ) : super(InitialStateData());
  static DataProductCubit get(context)=>BlocProvider.of(context);
  Product? products;
  void userCreate({
    required String name,
    required String price,
    required String size,
    required String Descreption,
    required String id,
    required var link,
  }){
    Product product =Product(
      name: name,
      price: price,
      Size: size,
      Description: Descreption,
      id: id,
      imgurl: link
    );
    FirebaseFirestore.instance.collection('Product').doc(product.id).set(product.toMap()!).then((value) {
      emit(GetDataSuccess());
    }).catchError((onError){
      emit(GetDataFailed(onError));
    });
  }



}