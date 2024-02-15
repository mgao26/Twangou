import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twangou/main.dart';
import 'package:twangou/initialize users/welcome_page.dart';
import 'package:twangou/main%20pages/NavigationBarPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer timer = Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarPage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.pink], begin: Alignment.topLeft, end: Alignment.bottomRight)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('twangou', style: GoogleFonts.pacifico(color: Colors.yellow, fontSize: 50),),
            SizedBox(height:20),
            Icon(Icons.card_giftcard, size: 100, color: Colors.yellow,)
          ],
        )
      )
    );
  }
}