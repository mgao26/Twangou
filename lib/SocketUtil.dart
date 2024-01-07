
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

class SocketUtil {
  late Socket socket;
  late Future<http.Response> response;

  Future<String> sendMessage(String message) async {
    print('connecting');
    Socket socket = await Socket.connect('192.168.1.240', 8080);
    print('connected');
    String response = '';
    // listen to the received data event stream

    // send hello
    socket.add(utf8.encode(message));
    socket.listen((List<int> event) {
      //print(utf8.decode(event));
      response = utf8.decode(event);
    });
    // wait 5 seconds
    await Future.delayed(Duration(seconds: 3));
    // .. and close the socket
    socket.close();
    return response;
  }
}