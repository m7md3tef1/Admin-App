import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/domin/Api/ProductApi.dart';
import 'package:untitled2/domin/GetProduct_Statet.dart';

import '../models/Product.dart';

class GetProductCubit extends Cubit<GetProductState>{
  late StreamSubscription<List<Product>> subscription;
  GetProductCubit() : super(ProductsLoading()){
    subscription=ProductApi().getProduct().listen((p) {
      emit(ProductsSuccess(p));
    })..onError((e){
      emit(ProductsFailed(e));
    });
  }
  @override
  Future<void> close()async
  {
    await subscription.cancel();
    super.close();
  }
}