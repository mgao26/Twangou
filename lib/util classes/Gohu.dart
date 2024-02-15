
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

class Gohu {
  String title;
  String description;
  List<Product> products;
  Gohu(this.title, this.description, this.products);

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'products': products.map((product) => product.toJson()).toList(),
  };

  // Create Gohu instance from a Map
  factory Gohu.fromJson(Map<String, dynamic> json) => Gohu(
    json['title'],
    json['description'],
    (json['products'] as List<dynamic>).map((productJson) => Product.fromJson(productJson)).toList(),
  );
}

class Product {
  String name;
  Uint8List imageBytes;
  int quantity;

  Product(this.name, this.imageBytes, this.quantity);

  // Convert Product instance to a Map
  Map<String, dynamic> toJson() => {
    'name': name,
    'imageBytes': base64Encode(imageBytes),
    'quantity': quantity,
  };

  // Create Product instance from a Map
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    json['name'],
    base64Decode(json['imageBytes']),
    json['quantity'],
  );
}