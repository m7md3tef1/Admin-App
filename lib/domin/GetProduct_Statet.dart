import 'package:untitled2/models/Product.dart';

abstract class GetProductState{
}


//AddProductStream
class ProductsLoading extends GetProductState{}
class ProductsSuccess extends GetProductState{
  final List<Product> products;
  ProductsSuccess(this.products);
}

class ProductsFailed extends GetProductState {
  final String msg;

  ProductsFailed(this.msg);
}