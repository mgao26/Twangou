import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:twangou/util%20classes/Gohu.dart';
import 'package:twangou/util%20classes/ImageFrame.dart';

import '../../../main.dart';

class GohuProducts extends StatefulWidget {
  Gohu gohu;
  GohuProducts({super.key, required this.gohu});

  @override
  State<GohuProducts> createState() => GohuProductsState();
}

class GohuProductsState extends State<GohuProducts> {
  List<Product> products = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void addProduct(Product product) {
    products.add(product);
    print(products);
    Navigator.pop(context);
    setState(() {});
  }

  void addProductDialog() {
    int quantity = 0;
    double sliderValue = 0;
    TextEditingController productName = TextEditingController();
    Uint8List imageBytes = Uint8List(0);
    TextEditingController cost = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          void onImageSelection(Uint8List imageSelectedBytes) {
            setState(() {
              imageBytes = imageSelectedBytes;
            });
          }

          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                children: [
                  SizedBox(height: height / 40),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Add Product',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: height / 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 20),
                    child: TextFormField(
                      controller: productName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Enter Product Name Here...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: height / 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width / 20),
                    child: TextFormField(
                      controller: cost,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Enter Product Cost',
                        prefixText: '\$',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a cost';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: height / 40),
                  ImageFrame(
                      width: width / 2,
                      spacing: height / 40,
                      title: 'Add Product Image',
                      fontSize: 18,
                      callback: onImageSelection),
                  SizedBox(height: height / 40),
                  Text(
                    'Item Quantity: $quantity',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: sliderValue,
                    onChanged: (newValue) => setState(() {
                      quantity = newValue.round();
                      sliderValue = newValue;
                    }),
                    min: 0,
                    max: 1000,
                  ),
                  SizedBox(height: height / 40),
                  productName.text != '' && cost.text != '' && quantity != 0 && imageBytes != Uint8List(0) ? TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red, // Set the opacity here
                      ),
                      onPressed: () {
                        Product product = Product(productName.text, imageBytes,
                            quantity, double.parse(cost.text));
                        addProduct(product);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.yellow),
                      )) : TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.5), // Set the opacity here
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.yellow.withOpacity(0.5)),
                      )),
                  SizedBox(height: height / 80),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey, // Set the opacity here
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.blue),
                      )),
                ],
              ),
              ),
            ));
          });
        });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product Options'),
          centerTitle: true,
        ),
        body: Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: ListView.builder(
                      itemCount: products.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                          Container(
                            width: width / 3,
                            height: width / 3,
                            child: Image.memory(
                              products[index].imageBytes,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(products[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          Column(children: [
                            Text('Quantity: ${products[index].quantity}'),
                            Text('Cost: \$${products[index].cost}'),
                          ]),
                        ]);
                      }),
                ),
                Positioned(
                  bottom: height / 30, // Adjust this value as needed
                  left: width / 8, // Adjust this value as needed
                  child: Column(children: [
                    Container(
                        width: width * (6 / 8),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.red, // Set the opacity here
                            ),
                            onPressed: () {
                              addProductDialog();
                            },
                            child: Text(
                              'New Produce/Merchandise...',
                              style: TextStyle(color: Colors.yellow),
                            ))),
                    Container(
                        width: width * (6 / 8),
                        child: products.length > 0 ? TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.grey, // Set the opacity here
                            ),
                            onPressed: () {
                              widget.gohu.products = products;
                              Navigator.pop(context);
                              Navigator.pop(context, widget.gohu);
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.blue),
                            )) : TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                              Colors.grey.withOpacity(0.5), // Set the opacity here
                            ),
                            onPressed: () {
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.blue),
                            ))
                    ),
                  ]),
                ),
              ],
            )));
  }
}
