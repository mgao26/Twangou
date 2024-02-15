import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twangou/main%20pages/Create%20Pages/Create%20Gohu%20Pages/GohuProducts.dart';
import 'package:twangou/util%20classes/FindImagePage.dart';
import 'package:twangou/util%20classes/ImageFrame.dart';

class GohuTitles extends StatefulWidget {
  const GohuTitles({super.key});

  @override
  State<GohuTitles> createState() => GohuTitlesState();
}

class GohuTitlesState extends State<GohuTitles> {
  late double height;
  late double width;
  TextEditingController titleData = TextEditingController();
  TextEditingController descriptionData = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void onImageSelection(Uint8List imageBytes) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title:Text('New Gohu'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ImageFrame(width: width/2, spacing: height/40, title: 'Add Gohu Image', callback: onImageSelection, fontSize: 20,),
              Container(
                padding: EdgeInsets.all(width / 20),
                child: TextField(
                controller: titleData,
                decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'Enter Gohu Title Here...',
                ),
              ),
            ),
              Container(
                padding: EdgeInsets.all(width / 20),
                height: height/3,
                child: TextField(
                  controller: descriptionData,
                  textAlignVertical: TextAlignVertical.top,
                  expands: true,
                  maxLines: null,
                  decoration:  InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: 'Enter Gohu Description Here...',
                  ),
                ),
              ),
              Container(
                  color: Colors.red,
                  width: width * (7 / 8),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GohuProducts()));
                      },
                      child: Text('Next',
                          style: TextStyle(color: Colors.yellow)))),
              SizedBox(height:height/20),
          ]
        )
      ),
      )
    );
  }
}
