import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:twangou/main%20pages/Create%20Pages/Create%20Gohu%20Pages/GohuTitles.dart';
import 'package:twangou/util%20classes/SocketUtil.dart';

import '../../main.dart';
import '../../util classes/Gohu.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => CreatePageState();
}

class CreatePageState extends State<CreatePage> {
  late double height;
  late double width;
  bool isHostingExpanded = false;
  bool isCompletedExpanded = false;

  SocketUtil socketUtil = SocketUtil();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height / 50,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        isHostingExpanded = !isHostingExpanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hosting',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(isHostingExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  if (isHostingExpanded)
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: gohus.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                  width: 5,
                                                  color: Colors.black)),
                                          width: width / 3,
                                          height: width/3,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(7.0),
                                            // Adjust the radius as needed
                                            child: Image.memory(gohus[index].coverImageBytes, fit: BoxFit.fill),
                                          ),
                                        ),
                                        SizedBox(width: width / 30),
                                        Container(
                                          width: width / 5,
                                          height: (width / 48) * 5,
                                          child: AutoSizeText(
                                            gohus[index].title,
                                            style: TextStyle(fontSize: 50),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ]
                                ),
                                    TextButton(onPressed: () {
                                      showGohuInfo(gohus[index], context);
                                    }, child: Text('Info')),
                                  ],
                                ),
                                SizedBox(height: height / 40),
                              ],
                            );
                          }),
                    ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        isCompletedExpanded = !isCompletedExpanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Completed',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(isCompletedExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  if (isCompletedExpanded)
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 5,
                                                  color: Colors.black)),
                                          padding:
                                              EdgeInsets.only(top: height / 60),
                                          width: width / 4,
                                          height: (width / 16) * 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            // Adjust the radius as needed
                                            child: Image.asset(
                                              'assets/saving.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width / 30),
                                        Container(
                                          width: width / 2,
                                          height: (width / 48) * 5,
                                          child: AutoSizeText(
                                            'Title',
                                            style: TextStyle(fontSize: 50),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text('Date'),
                                  ],
                                ),
                                SizedBox(height: height / 40),
                              ],
                            );
                          }),
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: height / 30, // Adjust this value as needed
              left: width / 8, // Adjust this value as needed
              child: Container(
                  width: width * (6 / 8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red
                            .withOpacity(0.75), // Set the opacity here
                      ),
                      onPressed: () async{
                        Gohu gohu = await Navigator.push(context, MaterialPageRoute(builder: (context) => GohuTitles()));
                        //gohus.add(gohu);
                        sendGohu(gohu);
                        //String jsonObject = json.encode(gohu.toJson());
                        //String message = 'AddGohu|$jsonObject';
                        //String response = await socketUtil.sendMessage(message);
                        //saveGohus(gohus);
                        setState(() {
                        });
                      },
                      child: Text(
                        'Create New...',
                        style: TextStyle(color: Colors.yellow),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
