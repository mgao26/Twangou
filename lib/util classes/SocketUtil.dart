
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

  Future<String> sendMessage(String message, String route) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.240:5000$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Hi' : 'hello',
      },
      body: message,
    );
    String text = response.body;
    return text;
  }

  Future<String> sendImage(Uint8List image, String route, int id) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.240:5000$route'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Id' : '$id',
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