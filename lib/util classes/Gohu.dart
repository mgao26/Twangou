
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:twangou/util%20classes/SocketUtil.dart';

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

/*Future<List<Gohu>> loadGohus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? jsonStrings = prefs.getStringList("Gohus");
  print(jsonStrings![0]);
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
}*/

/*Future<List<Gohu>> loadGohus() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  Database db = await openDatabase('$path/twangou.db');
  String createGohusTable = "CREATE TABLE IF NOT EXISTS GOHUS(gohu_ID INTEGER PRIMARY KEY AUTOINCREMENT ,title TEXT, description TEXT, cover_image TEXT, num_of_products INTEGER); ";
  db.execute(createGohusTable);

  String createProductsTable = "CREATE TABLE IF NOT EXISTS PRODUCTS(name TEXT, quantity INTEGER, cost REAL, product_image TEXT, product_order INTEGER, gohu_id INTEGER);";
  db.execute(createProductsTable);
}

void saveGohu(Gohu gohu) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  Database db = await openDatabase('$path/twangou.db');

  int gohuId = await db.insert('GOHUS', {"title": gohu.title, "description": gohu.description});
  String coverImageFileName = "$path/Gohu${gohuId}Image.bin";
  db.insert("GOHUS", {"cover_image": coverImageFileName});
  File coverImageFile = File(coverImageFileName);
  await coverImageFile.writeAsBytes(gohu.coverImageBytes);

  for(int ii = 0; ii < gohu.products.length; ii++) {
    db.insert('PRODUCTS', {"name": gohu.products[ii].name, "quantity": gohu.products[ii].quantity, "cost": gohu.products[ii].cost, "product_order": ii + 1, "gohu_id": gohuId});
    String productImageFileName = "$path/Gohu${gohuId}Product${ii+1}Image.bin";
    db.insert("PRODUCTS", {"product_image": productImageFileName});
    File productImageFile = File(productImageFileName);
    await productImageFile.writeAsBytes(gohu.products[ii].imageBytes);
  }

}*/
Future<Gohu> loadGohu(int userId, int order) async {
  SocketUtil socketUtil = SocketUtil();
  Gohu gohu = Gohu('', '', [], Uint8List(0), 0);

  String response = await socketUtil.getRequest('user-id', 'order', '$userId', '$order', '/FetchGohu');
  response = response.substring(1, response.length - 1);
  List<String> parts = response.split(',');

  String gohuId = parts[0];
  String title =  parts[1].replaceAll("'", '').substring(1,);
  String description = parts[2].replaceAll("'", '').substring(1,);
  String coverImage = parts[3].replaceAll("'", '').substring(1,);
  int numOfProducts = int.parse(parts[4].substring(1,));

  gohu.gohuId = int.parse(gohuId);
  gohu.title = title;
  gohu.description = description;
  gohu.coverImageBytes = await socketUtil.getImage(coverImage, '/FetchImage');

  for(int ii = 0; ii < numOfProducts; ii++) {
    String response = await socketUtil.getRequest('gohu-id', 'order', '$gohuId', '${ii+1}', '/FetchProduct');
    response = response.substring(1, response.length - 1);
    List<String> parts = response.split(',');

    String name = parts[0].replaceAll("'", '').substring(1,);
    int quantity =  int.parse(parts[1].substring(1,));
    double cost = double.parse(parts[2].substring(1,));
    String productImage = parts[3].replaceAll("'", '').substring(1,);

    gohu.products.add(Product(name, await socketUtil.getImage(productImage, '/FetchImage'), quantity, cost));
    print('done');
  }
  return gohu;
}

Future<int> getNumOfGohus(int userId) async {
  SocketUtil socketUtil = SocketUtil();
  int numOfGohus = int.parse(await socketUtil.getRequest('user-id', '', "$userId", '', '/FetchNumberOfGohus'));
  return numOfGohus;
}

Future<List<Gohu>> loadGohus(int userId) async {
  SocketUtil socketUtil = SocketUtil();
  if (userId != 0) {
    List<Gohu> loadedGohus = [];
    int numOfGohus = await getNumOfGohus(userId);
    for (int ii = 0; ii < numOfGohus; ii++) {
      Gohu addedGohu = await loadGohu(userId, ii);
      loadedGohus.add(addedGohu);
    }
    return loadedGohus;
  } else {
    return [];
  }
}


Future<int> fetchId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int idNumber =  prefs.getInt('idNumber') ?? 0;
  return idNumber;
}

void sendGohu(Gohu gohu) async {

  SocketUtil socketUtil = SocketUtil();
  int userId = await fetchId();

  String messageData = '${gohu.title}|${gohu.description}|$userId|${gohu.products.length}';

  int gohuId = int.parse(await socketUtil.sendMessage(messageData, '/AddGohu'));
  print("Gohu ID: $gohuId");

  String response = await socketUtil.sendImage(gohu.coverImageBytes, '/AddGohu/AddCoverImage',gohuId);
  print(response);

  for(int ii = 0; ii < gohu.products.length; ii++) {
    String response = await socketUtil.sendMessage("${gohu.products[ii].name}|${gohu.products[ii].cost}|${gohu.products[ii].quantity}|${ii+1}|$gohuId", '/AddGohu/AddProduct');
    print(response);
    String response2 = await socketUtil.sendProductImage(gohu.products[ii].imageBytes, '/AddGohu/AddProductImage', gohuId, ii+1);
    print(response2);
  }

  /*for(int ii = 0; ii < gohu.products.length; ii++) {
    concatenatedData = concatenateBytes(concatenatedData, Uint8List.fromList(utf8.encode("|${gohu.products[ii].name}|${gohu.products[ii].cost}|${gohu.products[ii].quantity}|")));
    concatenatedData = concatenateBytes(concatenatedData, gohu.products[ii].imageBytes);
  }*/
  /*SocketUtil socketUtil = SocketUtil();
  String generalGohuData = '${gohu.title}|${gohu.description}|${gohu.products.length}';
  socketUtil.sendMessage(generalGohuData, '/AddGohu');



  socketUtil.sendMessageBytes(gohu.coverImageBytes, '/AddGohu');*/

}


class Gohu {
  String title;
  String description;
  List<Product> products;
  Uint8List coverImageBytes;
  int gohuId;
  Gohu(this.title, this.description, this.products, this.coverImageBytes, this.gohuId);

  /*Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'products': products.map((product) =>
        product.toJson()).toList(),
    'coverImageBytes': base64Encode(coverImageBytes),
  };

  // Create Gohu instance from a Map
  factory Gohu.fromJson(Map<String, dynamic> json) => Gohu(
    json['title'],
    json['description'],
    (json['products'] as List<dynamic>).map((productJson) => Product.fromJson(productJson)).toList(),
    base64Decode(json['coverImageBytes']),

  );*/

}

class Product {
  String name;
  Uint8List imageBytes;
  int quantity;
  double cost;

  Product(this.name, this.imageBytes, this.quantity, this.cost);

  // Convert Product instance to a Map
  /*Map<String, dynamic> toJson() => {
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
  );*/
}