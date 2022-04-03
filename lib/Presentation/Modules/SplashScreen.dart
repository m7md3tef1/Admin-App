import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/Presentation/Modules/DeleteProduct.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: AnimatedSplashScreen(
        duration: 3000,
        nextScreen: const DeleteProduct(),
        splash: LayoutBuilder(
            builder: (context, cons) => Center(
              child: Image(
                  image:const AssetImage('Image/100.jpg'),

                  height: cons.maxHeight ,
                  width: cons.maxWidth
              ),
            )),
      ),
    );

  }
}
