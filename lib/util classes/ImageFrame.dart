import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twangou/util%20classes/FindImageGalleryPage.dart';

import 'FindImagePage.dart';

class ImageFrame extends StatefulWidget {
  ImageFrame(
      {super.key,
      required this.width,
      required this.spacing,
      required this.title,
      required this.callback,
      required this.fontSize});

  double width;
  double spacing;
  double fontSize;
  String title;
  final Function(Uint8List) callback;

  @override
  State<ImageFrame> createState() => ImageFrameState();
}

class ImageFrameState extends State<ImageFrame> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
  }

  void selectImage() async {
    imageBytes = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImageSearchWidget()));
    setState(() {});
    widget.callback(imageBytes!);
  }

  void selectImageGallery() async {
    imageBytes = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FindImageGalleryPage()));
    setState(() {});
    widget.callback(imageBytes!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: widget.width,
        height: widget.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: imageBytes == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: widget.fontSize, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: widget.spacing),
                  InkWell(
                    onTap: selectImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Web Search',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: widget.fontSize - 6),
                        ),
                        Icon(Icons.search, color: Colors.blue)
                      ],
                    ),
                  ),
                  SizedBox(height: widget.spacing),
                  InkWell(
                    onTap: selectImageGallery,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your Photos',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: widget.fontSize - 6)),
                        Icon(Icons.photo, color: Colors.blue)
                      ],
                    ),
                  ),
                ],
              )
            : GestureDetector(
                child: Image.memory(imageBytes!, fit: BoxFit.fill,),
                onDoubleTap: () => setState(() {
                  imageBytes = null;
                }),
              ),
      ),
      Text('Double Tap to Delete Image',
          style: TextStyle(fontSize: widget.fontSize - 6)),
    ]);
  }
}
