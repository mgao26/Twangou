import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../initialize users/welcome_page.dart';
import '../main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String username = '';
  String password = '';

  @override
  void initState() {
    fetchUsername().then((value) => setState(() {
          username = value;
        }));
    super.initState();
  }

  Future<String> fetchUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    return username;
  }

  Future<String> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return "signed out";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(username),
            TextButton(onPressed: () {
              gohus = [];
              signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen())));
            }, child: Text('SIGN OUT'))
          ],
        ),
      ),
    );
  }
}
