import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Presentation/dialouges/toast.dart';
import 'package:untitled2/constant/screens.dart';
import 'package:untitled2/domin/GetProduct_Cubit.dart';
import 'package:untitled2/domin/GetProduct_Statet.dart';

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<GetProductCubit, GetProductState>(
          builder: (context, state) {
        if (state is ProductsSuccess) {
          return SingleChildScrollView(
            child: SafeArea(

                child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(

                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: Container(
                      height: 53,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, AddProductScreenPath);
                              },
                              child: const Icon(
                                Icons.west,
                                color: Colors.black,
                                size: 20,
                              )),
                          label: const Center(
                            child: Text(
                              'Products',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      height: 900,
                      width: double.infinity,
                      child: GridView.builder(
                          itemCount: state.products.length,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: .7, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return Stack(
                              children: [
                                Badge(
                                  position:
                                      const BadgePosition(top: 0, end: 1,),
                                  badgeColor: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                  badgeContent: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              title: const Text('Sure Delete'),
                                              children: [
                                                SimpleDialogOption(
                                                  child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel')),
                                                ),
                                                SimpleDialogOption(
                                                  child: InkWell(
                                                      onTap: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'Product')
                                                            .doc(product.id)
                                                            .delete()
                                                            .then(
                                                                (value) async {
                                                          state.products[index];
                                                          showToast(
                                                              msg: 'Done',
                                                              state:
                                                                  ToastedStates
                                                                      .SUCCESS);
                                                        }).catchError(
                                                                (onError) {
                                                          showToast(
                                                              msg: onError
                                                                  .toString(),
                                                              state:
                                                                  ToastedStates
                                                                      .SUCCESS);
                                                        });
                                                        Navigator.pop(context);
                                                        showToast(
                                                            msg:
                                                                '${product.name}'
                                                                ' '
                                                                'تم حذف المنتج',
                                                            state: ToastedStates
                                                                .SUCCESS);
                                                      },
                                                      child:
                                                          const Text('Delete')),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 600,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.green[200],
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(7),
                                              bottomRight: Radius.circular(7),
                                            )),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: SizedBox(
                                                      child: Container(
                                                        height: 90,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .transparent),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                color: Colors
                                                                    .grey[200],
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image: NetworkImage(
                                                                      product.imgurl),
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                        EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'id: ',
                                                          style: TextStyle(
                                                              color:
                                                              Colors.green,
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        product.id!,
                                                        style: const TextStyle(
                                                            color:
                                                            Colors.black87,
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Name: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        product.name!,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Price:  ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(product.price!,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Description:',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        product.Description!,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        child: Text(
                                                          'Size: ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        product.Size!,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
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
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            )),
          );
        } else if (state is ProductsFailed) {
          return Center(child: Text(state.msg));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
