import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late TextEditingController userNameData;
  late TextEditingController passwordData;
  late double height;
  late double width;

  @override
  void initState() {
    super.initState();
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
              'Enter a Username and Password',
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
              'Give us a unique username and strong password to get started.',
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
              controller: passwordData,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
          SizedBox(height: height / 20),
          Align(
            alignment: Alignment.center,
            child: Container(
                color: Colors.red,
                width: width * (7 / 8),
                child: TextButton(
                    onPressed: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));*/
                    },
                    child: Text('Continue',
                        style: TextStyle(color: Colors.yellow)))),
          ),
        ],
      ),
    );
  }
}
