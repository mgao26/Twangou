
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

void showGohuInfo(Gohu gohu, BuildContext context) {
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text(gohu.title, textAlign: TextAlign.center,),
      content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width/3,
                height: width/3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child:
                Image.memory(gohu.coverImageBytes, fit: BoxFit.fill,),
              ),
              SizedBox(height: height/40),
              Align(alignment: Alignment.center, child: Text(gohu.description)),
              SizedBox(height: height/40),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: gohu.products.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width / 3,
                            height: width / 3,
                            child: Image.memory(
                              gohu.products[index].imageBytes,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Column(children: [
                            Container(
                              width: width / 4,
                              height: (width / 48) * 5,
                              child: AutoSizeText(
                                gohu.products[index].name,
                                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text('Quantity: ${gohu.products[index].quantity}'),
                            Text('Cost: \$${gohu.products[index].cost}'),
                          ]),
                        ]);
                  }),
            ],
          )
      ),
    );
  });
}

Future<List<Gohu>> loadGohus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonStrings = prefs.getStringList("Gohus");
  List<Gohu> gohus = [];
  if (jsonStrings != null) {
    List jsonMapList = jsonStrings.map((jsonObject) =>
        json.decode(jsonObject)).toList();
    gohus = jsonMapList.map((jsonString) =>
        Gohu.fromJson(jsonString)).toList();
  }
  return gohus;
}

void saveGohus(List<Gohu> gohus) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List jsonMapList = gohus.map((gohu) => gohu.toJson()).toList();
  List<String> gohuStringList = jsonMapList.map((jsonObject) => json.encode(jsonObject)).toList();
  prefs.setStringList("Gohus", gohuStringList);
}

class Gohu {
  String title;
  String description;
  List<Product> products;
  Uint8List coverImageBytes;
  Gohu(this.title, this.description, this.products, this.coverImageBytes);

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'products': products.map((product) => product.toJson()).toList(),
    'coverImageBytes': base64Encode(coverImageBytes),
  };

  // Create Gohu instance from a Map
  factory Gohu.fromJson(Map<String, dynamic> json) => Gohu(
    json['title'],
    json['description'],
    (json['products'] as List<dynamic>).map((productJson) => Product.fromJson(productJson)).toList(),
    base64Decode(json['coverImageBytes']),
  );

}

class Product {
  String name;
  Uint8List imageBytes;
  int quantity;
  double cost;

  Product(this.name, this.imageBytes, this.quantity, this.cost);

  // Convert Product instance to a Map
  Map<String, dynamic> toJson() => {
    'name': name,
    'imageBytes': base64Encode(imageBytes),
    'quantity': quantity,
    'cost': cost,
  };

  // Create Product instance from a Map
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    json['name'],
    base64Decode(json['imageBytes']),
    json['quantity'],
    json['cost']
  );
}