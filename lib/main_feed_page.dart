import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainFeedPage extends StatefulWidget {
  const MainFeedPage({super.key});

  @override
  State<MainFeedPage> createState() => MainFeedPageSate();
}

class MainFeedPageSate extends State<MainFeedPage> {

  @override
  void initState() {
    super.initState();
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