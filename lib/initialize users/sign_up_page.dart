import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twangou/util%20classes/SocketUtil.dart';
import 'package:twangou/main%20pages/NavigationBarPage.dart';
import 'package:twangou/initialize%20users/sign_in_page.dart';

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
  SocketUtil socketutil = SocketUtil();
  final _formKey = GlobalKey<FormState>();
  bool userNameValidator = false;
  String userNameError = '';
  bool passwordValidator = false;
  String passwordError = '';

  @override
  void initState() {
    super.initState();
    userNameValidator = false;
    userNameError = '';
    passwordValidator = false;
    passwordError = '';
    userNameData = TextEditingController();
    passwordData = TextEditingController();
  }

  void saveId(int idNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('idNumber', idNumber);
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
              decoration:  InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: userNameError != '' ? Colors.red : Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: userNameError != '' ? Colors.red : Colors.grey),
                ),
                hintText: 'Username',
              ),
              onChanged: (value) {
                // You can perform validation here
                // For example, check for the presence of a number
                bool hasSpecialCharacter = value.contains('|');
                bool hasSpace = value.contains(' ');
                bool isLongEnough = value.length >= 8;
                if (hasSpecialCharacter) {
                  // Show error or handle accordingly
                  userNameError = 'Username cannot contain the | character';
                  userNameValidator = false;
                } else if (hasSpace) {
                  userNameError = 'Username cannot have spaces';
                  userNameValidator = false;
                } else if (!isLongEnough) {
                  userNameError = 'Username must be at least 8 characters';
                  userNameValidator = false;
                } else {
                  userNameError = '';
                  userNameValidator = true;
                }
              },
            ),
          ),
          userNameError != '' ?
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: Text(userNameError,
                style: TextStyle(
                    color: Colors.red),
                textAlign: TextAlign.start),
          ) :
          SizedBox(),
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
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: passwordError != '' ? Colors.red : Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: passwordError != '' ? Colors.red : Colors.grey),
                ),
                hintText: 'Password',
              ),
              onChanged: (value) {
                // You can perform validation here
                // For example, check for the presence of a number
                bool hasNumber = value.contains(RegExp(r'\d'));
                bool hasSpecialCharacter = value.contains('|');
                bool hasSpace = value.contains(' ');
                bool isLongEnough = value.length >= 8;
                if (hasSpecialCharacter) {
                  // Show error or handle accordingly
                  passwordError = 'Password cannot contain the | character';
                  passwordValidator = false;
                } else if (hasSpace) {
                  passwordError = 'Password cannot have spaces';
                  passwordValidator = false;
                } else if (!isLongEnough) {
                  passwordError = 'Password must be at least 8 characters';
                  passwordValidator = false;
                } else if (!hasNumber) {
                  passwordError = 'Password must contain a number';
                  passwordValidator = false;
                } else {
                  passwordError = '';
                  passwordValidator = true;
                }
              },
            ),
          ),
          passwordError != '' ?
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 20),
            child: Text(passwordError,
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
                    onPressed: () async {
                      setState(() {

                      });
                      if (userNameValidator && passwordValidator) {
                        String message = 'SignUp|${userNameData.text}|${passwordData.text}';
                        String response = await socketutil.sendMessage(message, '/');
                        List<String> responseParts = response.split('|');
                        if (responseParts[0] == 'Available') {
                          userNameError = '';
                          int idNumber = int.parse(responseParts[1]);
                          print(idNumber);
                          saveId(idNumber);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarPage()));
                        } else {
                          userNameError = 'Username is taken.';
                          setState(() {});
                        }
                      }
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
