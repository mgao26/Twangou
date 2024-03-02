import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:twangou/main.dart';

import '../util classes/Gohu.dart';
import '../util classes/HalfOvalPainter.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  late double height;
  late double width;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print("$height");
    print("$width");
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height / 40,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.only(left: width / 50),
              child: Text(
                'twangou',
                style: GoogleFonts.pacifico(color: Colors.red, fontSize: 30),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Handle elevated button press
                  },
                  child: const Icon(
                    Icons.group,
                    size: 30,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Handle elevated button press
                  },
                  child: const Icon(Icons.search, size: 30),
                ),
              ],
            ),
          ]),
          Divider(
            color: Colors.grey,
            thickness: 4.0,
          ),
          Container(
            padding: EdgeInsets.only(left: width / 50),
            child: Text("Your Gohus",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            alignment: Alignment.centerLeft,
          ),
          Container(
            height: height / 2,
            padding: EdgeInsets.only(
                left: width / 50,
                right: width / 50,
                top: height / 60,
                bottom: height / 60),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gohus.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(children: [
                    Padding(padding: EdgeInsets.only(left: width / 50)),
                    Column(children: [
                      /*CustomPaint(
                        painter: HalfOvalPainter(
                            fillColor: Colors.red,
                            borderColor: Colors.yellow,
                            borderWidth: 6),
                        child: Container(
                          width: (width / (2.8)) + (width / 25) + 6,
                          height: height / 15,
                        ),
                      ),*/
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(width: 6, color: Colors.yellow),
                        ),
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: width / 50)),
                            Column(children: [
                              Container(
                                padding: EdgeInsets.only(top: height / 60),
                                width: width / (2.8),
                                height: (height / 18) * 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  // Adjust the radius as needed
                                  child: Image.memory(
                                    gohus[index].coverImageBytes,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                height: (height / 18) * 1,
                                child: AutoSizeText(
                                  gohus[index].title,
                                  style: TextStyle(fontSize: 50),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(onPressed: () {
                                showGohuInfo(gohus[index], context);
                              }, child: Text('Info')),
                            ]),
                            Padding(
                                padding: EdgeInsets.only(right: width / 50)),
                          ],
                        ),
                      ),
                    ]),
                    Padding(padding: EdgeInsets.only(right: width / 50)),
                  ]);
                }),
          ),
          Divider(
            color: Colors.grey,
            thickness: 4.0,
          ),
          Container(
            padding: EdgeInsets.only(left: width / 50),
            child: Text("Gohus for You",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            alignment: Alignment.centerLeft,
          ),
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.black)),
                    padding: EdgeInsets.only(top: height / 60),
                    width: width,
                    height: (width / 4) * 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      // Adjust the radius as needed
                      child: Image.asset(
                        'assets/saving.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: width / 50),
                    alignment: Alignment.centerLeft,
                    child: Text("FarmHouse Chicken Thighs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: width / 50),
                    alignment: Alignment.centerLeft,
                    child: Text("Hosted by Michelle Wang",
                        style: TextStyle(fontSize: 15, color: Colors.grey)),
                  ),
                  SizedBox(height: height/40),
                  Container(
                    padding: EdgeInsets.only(left: width / 50),
                    alignment: Alignment.centerLeft,
                    child: ReadMoreText(
                      "This brand of chicken thigh is juicy and succulent when cooked. The chickens are humanely treated wtih free range pens and are slaughtered painlessly.",
                      trimLines: 2,
                      style: TextStyle(fontSize: 15, color: Colors.black,),
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Read more',
                      trimExpandedText: ' Read less',
                    ),
                  ),
                  SizedBox(height: height/30,)
                ]);
              }),
        ],
      ),
    );
  }
}

