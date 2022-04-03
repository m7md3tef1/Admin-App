
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/constant/screens.dart';
import 'package:untitled2/domin/ProductCubit.dart';
import 'package:untitled2/domin/ProductState.dart';
import 'package:untitled2/models/Product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static String id = 'AddProduct';
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String Name = '';
  var price = '';
  String Description = '';
  var size = '';
  var id = '';
  String link = '';
   PickedFile? c;
   File? e;
  Product product = Product();
 var  adminKey = GlobalKey<FormState>();
  var s = true;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerSize= TextEditingController();
  TextEditingController controllerDes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataProductCubit,DataProductState>(
      listener: (context, state) {} ,
        builder: (context, state)=> Scaffold(
          backgroundColor: Colors.grey[200],
          body: InkWell(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: SafeArea
                (
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,

                            prefixIcon: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.west,
                                  color: Colors.black,
                                  size: 20,
                                )),
                            label: const Center(
                              child: Text(
                                'Add Product',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  const SimpleDialogOption(
                                    child: Text('Pick Photo'),
                                  ),
                                  SimpleDialogOption(
                                    child: InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          c = (await ImagePicker.platform
                                              .pickImage(source: ImageSource.gallery))!;
                                          setState(() {
                                            e = File(c!.path);
                                          });
                                        },
                                        child: const Text('Pick From Gallery')),
                                  ),
                                  SimpleDialogOption(
                                    child: InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          c = (await ImagePicker.platform
                                              .pickImage(source: ImageSource.camera))!;
                                          setState(() {
                                            e = File(c!.path);
                                          });
                                        },
                                        child: const Text('Pick From Camera')),
                                  ),
                                ],
                              );
                            });
                      },
                      child: c==null
                          ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.lightGreen,
                                size: 40,
                              ),
                            )),
                          )
                          : Image.file(
                        File(c!.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Form(
                        key: adminKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomTextForm(
                                'Product Name',
                                'Name',
                                (v) {
                                  setState(() {
                                    Name = v;
                                  });
                                },
                                (v) {
                                  if (v.toString().isEmpty) {
                                    return 'Please Enter Name';
                                  }
                                },


                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomTextForm(

                                'Product Price',
                                ' Price',
                                (v) {
                                  setState(() {
                                    price = v;
                                  });
                                },
                                (v) {
                                  if (v.toString().isEmpty) {
                                    return 'Please Enter Price';
                                  }
                                },
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomTextForm(
                                'Product Description',
                                  'Description',
                                (v) {
                                  setState(() {
                                    Description = v;
                                  });
                                },
                                (v) {
                                  if (v.toString().isEmpty) {
                                    return 'Please Enter Description ';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextFormField(
                                decoration: InputDecoration(

                                  labelText: 'id' ,
                                  hintText: 'id',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onSaved: (v) {
                                  setState(() {
                                    id  = v!;
                                  });
                                },
                                 validator:  (v) {
                                   if (v.toString().isEmpty) {
                                     return 'Please Enter size ';
                                   }
                                 },
                              )),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CustomTextForm(
                                'size',
                                'size',
                                    (v) {
                                  setState(() {
                                    size = v;
                                  });
                                },
                                    (v) {
                                  if (v.toString().isEmpty) {
                                    return 'Please Enter size ';
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: InkWell(
                                    onTap: () async {
                                      try{
                                      if (adminKey.currentState!.validate()) {
                                        adminKey.currentState?.save();
                                        DataProductCubit.get(context).userCreate(name: Name,
                                            price: price,
                                            size: size,
                                            id: id,
                                            Descreption: Description ,
                                            link: link
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text( Name +''+'تم اضافه ' )));
                                        await FirebaseStorage.instanceFor(
                                            bucket: 'gs://ecommercer2.appspot.com')
                                            .ref(c!.path)
                                            .putFile(e!);
                                        var url = await FirebaseStorage.instanceFor(
                                            bucket: 'gs://ecommercer2.appspot.com')
                                            .ref(c!.path)
                                            .getDownloadURL();
                                        print(url);
                                        setState(() {
                                          link = url;
                                        });

                                      }
                                    }
                                    catch(e){
                                        print(e.toString());
                                    }},

                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width*.60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.lightGreen,
                                       // border: Border.all(color: Colors.grey),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          children:  [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children:const [
                                                Icon(
                                                  Icons.add_box_rounded,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children:const [
                                                  Text(
                                                    'Add Product',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 19),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(onPressed: (){
                                  Navigator.pushNamed(context, deleteProductPath);
                                }, child: const Text('Show All Product',style: TextStyle(fontWeight: FontWeight.bold),))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  TextFormField CustomTextForm(label,hint, onSaved, validator) {
    return TextFormField(
      decoration: InputDecoration(

        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
