import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twangou/main%20pages/Create%20Pages/Create%20Gohu%20Pages/GohuProducts.dart';
import 'package:twangou/util%20classes/FindImagePage.dart';
import 'package:twangou/util%20classes/ImageFrame.dart';

import '../../../util classes/Gohu.dart';

class GohuTitles extends StatefulWidget {
  const GohuTitles({super.key});

  @override
  State<GohuTitles> createState() => GohuTitlesState();
}

class GohuTitlesState extends State<GohuTitles> {
  late double height;
  late double width;
  Uint8List imageBytes = Uint8List(0);
  Gohu gohu = Gohu('', '', [], Uint8List(0));
  TextEditingController titleData = TextEditingController();
  TextEditingController descriptionData = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void onImageSelection(Uint8List imageSelectedBytes) {
    setState(() {
      imageBytes = imageSelectedBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('New Gohu'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  ImageFrame(
                    width: width / 2,
                    spacing: height / 40,
                    title: 'Add Gohu Image',
                    callback: onImageSelection,
                    fontSize: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(width / 20),
                    child: TextFormField(
                      controller: titleData,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Enter Gohu Title Here...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(width / 20),
                    height: height / 3,
                    child: TextFormField(
                      controller: descriptionData,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Enter Gohu Description Here...',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  Container(
                      color: Colors.red,
                      width: width * (7 / 8),
                      child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              gohu.title = titleData.text;
                              gohu.description = descriptionData.text;
                              gohu.coverImageBytes = imageBytes;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GohuProducts(
                                            gohu: gohu,
                                          )));
                            }
                          },
                          child: Text('Next',
                              style: TextStyle(color: Colors.yellow)))),
                  SizedBox(height: height / 20),
                ])),
          ),
        ));
  }
}
