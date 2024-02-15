import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twangou/initialize users/sign_up_page.dart';
import 'package:twangou/initialize users/sign_in_page.dart';

import '../main.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(255, 255, 255, 100),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'twangou',
                    style:
                        GoogleFonts.pacifico(color: Colors.red, fontSize: 50),
                  ),
                  SizedBox(height: 20),
                  Icon(
                    Icons.card_giftcard,
                    size: 100,
                    color: Colors.yellow,
                  )
                ]),
                Row(children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/networking.png').image,
                            fit: BoxFit.contain),
                      )),
                  Text('Organize.', style: TextStyle(fontSize: 20))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('Buy.', style: TextStyle(fontSize: 20)),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/buying.png').image,
                            fit: BoxFit.contain),
                      )),
                ]),
                Row(children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/saving.png').image,
                            fit: BoxFit.contain),
                      )),
                  Text('Save.',
                      style: TextStyle(fontSize: 20, color: Colors.green))
                ]),
                SizedBox(
                  height: height / 20,
                ),
                Text(
                  "Join the only group buying app you'll ever need",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height / 20),
                Container(
                    color: Colors.red,
                    width: width * (7 / 8),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text('Sign Up',
                            style: TextStyle(color: Colors.yellow)))),
                SizedBox(height: height / 30),
                Container(
                    color: Colors.grey,
                    width: width * (7 / 8),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        child: Text('Sign In'))),
              ],
            )));
  }
}