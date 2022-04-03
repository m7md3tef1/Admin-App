import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Presentation/Modules/AddProduct.dart';
import 'package:untitled2/Presentation/Modules/SplashScreen.dart';
import 'package:untitled2/app_route.dart';
import 'package:untitled2/domin/GetProduct_Cubit.dart';
import 'package:untitled2/domin/ProductCubit.dart';
import 'package:untitled2/domin/ProductState.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       MultiBlocProvider(
         providers: [
           BlocProvider(create: (_)=>DataProductCubit()),
           BlocProvider(create: (_)=>GetProductCubit()),
         ],
         child: BlocBuilder<DataProductCubit,DataProductState>(
           builder:(context,state)=>
            MaterialApp(
             debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoute().onGenerateRoute,
    ),
         ),
       );
  }
}

