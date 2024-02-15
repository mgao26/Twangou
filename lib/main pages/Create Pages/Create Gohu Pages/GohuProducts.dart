import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:twangou/util%20classes/Gohu.dart';
import 'package:twangou/util%20classes/ImageFrame.dart';

import '../../../main.dart';

class GohuProducts extends StatefulWidget {
  const GohuProducts({super.key});

  @override
  State<GohuProducts> createState() => GohuProductsState();
}

class GohuProductsState extends State<GohuProducts> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
  }

  void addProduct(Product product) {
    products.add(product);
  }

  void addProductDialog() {
    int quantity = 0;
    double sliderValue = 0;
    TextEditingController productName = TextEditingController();
    Uint8List imageBytes = Uint8List(0);
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
                    child: TextField(
                      controller: productName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Enter Product Name Here...',
                      ),
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
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red, // Set the opacity here
                        ),
                        onPressed: () {
                          Product product = Product(productName.text, imageBytes, quantity);
                          addProduct(product);
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(color: Colors.yellow),
                        )),
                  SizedBox(height: height / 40),
                ],
              ),
            ));
          });
        });
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
                  child: Column(
                    children: [],
                  ),
                ),
                Positioned(
                  bottom: height / 30, // Adjust this value as needed
                  left: width / 8, // Adjust this value as needed
                  child: Container(
                      width: width * (6 / 8),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red, // Set the opacity here
                          ),
                          onPressed: () {
                            addProductDialog();
                          },
                          child: Text(
                            'New Produce/Merchandise...',
                            style: TextStyle(color: Colors.yellow),
                          ))),
                ),
              ],
            )));
  }
}
