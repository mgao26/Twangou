import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twangou/util%20classes/SocketUtil.dart';

import '../main pages/NavigationBarPage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  late TextEditingController userNameData;
  late TextEditingController passwordData;
  late double height;
  late double width;
  SocketUtil socketUtil = SocketUtil();
  String credentialsError = '';

  @override
  void initState() {
    super.initState();
    credentialsError = '';
    userNameData = TextEditingController();
    passwordData = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: ListView(

        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome Back',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height / 50,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Input your username and password to login.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: height / 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: const Text(
              'USERNAME',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(58, 58, 58, 1),
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: height / 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: TextField(
              controller: userNameData,
              decoration:  InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: credentialsError != '' ? Colors.red : Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: credentialsError != '' ? Colors.red : Colors.grey),
                ),
                hintText: 'Username',
              ),
            ),
          ),
          SizedBox(
            height: height / 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: const Text('PASSWORD',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(58, 58, 58, 1)),
                textAlign: TextAlign.start),
          ),
          SizedBox(
            height: height / 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: TextField(
              obscureText: true,
              controller: passwordData,
              decoration:  InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: credentialsError != '' ? Colors.red : Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: credentialsError != '' ? Colors.red : Colors.grey),
                ),
                hintText: 'Password',
              ),
            ),
          ),
          credentialsError != '' ?
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: Text(credentialsError,
                style: TextStyle(
                    color: Colors.red),
                textAlign: TextAlign.start),
          ) :
          SizedBox(),
          SizedBox(height: height / 20),
          Align(
            alignment: Alignment.center,
            child: Container(
                color: Colors.red,
                width: width * (7 / 8),
                child: TextButton(
                    onPressed: () async{
                      String message = 'SignIn|${userNameData.text}|${passwordData.text}';
                      String response = await socketUtil.sendMessage(message);

                      if (response == 'Incorrect') {
                        credentialsError = 'Invalid username or password.';
                        setState(() {});
                      } else {
                        credentialsError = '';
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarPage()));
                      }

                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));*/
                    },
                    child: Text('Continue',
                        style: TextStyle(color: Colors.yellow)))),
          ),
        ],
      ),
    );
  }
}