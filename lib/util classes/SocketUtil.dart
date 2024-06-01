
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'Gohu.dart';

class SocketUtil {
  late Socket socket;
  late Future<http.Response> response;
  Future<String> getRequest(String arg1name, String arg2name, String arg1, String arg2, String route) async{
    final response = await http.get(Uri.parse('http://192.168.1.240:5000$route?$arg1name=$arg1&$arg2name=$arg2'));
    String text = response.body;
    return text;
  }

  Future<Uint8List> getImage(String fileName, String route) async{
    final response = await http.get(Uri.parse('http://192.168.1.240:5000$route?file-name=$fileName'));
    Uint8List image = response.bodyBytes;
    return image;
  }

  Future<String> sendMessage(String message, String route) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.240:5000$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: message,
    );
    String text = response.body;
    return text;
  }

  Future<String> sendImage(Uint8List image, String route, int gohuId) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.240:5000$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Gohu-Id': '$gohuId',
      },
      body: image,
    );
    String text = response.body;
    return text;
  }

  Future<String> sendProductImage(Uint8List image, String route, int gohuId, int orderNumber) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.240:5000$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Gohu-Id': '$gohuId',
        'Order-Number': '$orderNumber',
      },
      body: image,
    );
    String text = response.body;
    return text;
  }


  Future<String> sendMessageBytes(Uint8List message, String route) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.240:5000$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: message,
    );
    String text = response.body;
    return text;
  }
}