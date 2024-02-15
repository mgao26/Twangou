import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FindImageGalleryPage extends StatefulWidget {
  const FindImageGalleryPage({super.key});

  @override
  State<FindImageGalleryPage> createState() => FindImageGalleryPageState();
}

class FindImageGalleryPageState extends State<FindImageGalleryPage> {
  String imagepath = '';
  Uint8List imageBytes = Uint8List(0);
  final ImagePicker imgpicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<Uint8List> openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if(pickedFile != null){
        imagepath = pickedFile.path;
        print(imagepath);
        //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

        File imagefile = File(imagepath); //convert Path to File
        imageBytes = await imagefile.readAsBytes(); //convert to bytes//convert bytes to base64 string
        /* Output:
              /9j/4Q0nRXhpZgAATU0AKgAAAAgAFAIgAAQAAAABAAAAAAEAAAQAAAABAAAJ3
              wIhAAQAAAABAAAAAAEBAAQAAAABAAAJ5gIiAAQAAAABAAAAAAIjAAQAAAABAAA
              AAAIkAAQAAAABAAAAAAIlAAIAAAAgAAAA/gEoAA ... long string output
              */
        //decode base64 stirng to bytes
        setState(() {

        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
    return imageBytes;
  }

  @override
  Widget build(BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Row(children: [
            Text('SEND IMAGE'),
            Icon(Icons.image)
          ]),
          content: Column(
              children: [
                imagepath != ""?Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(image: DecorationImage(image: Image.file(File(imagepath)).image, fit: BoxFit.contain)),):
                Container(
                  child: Text("No Image selected."),
                ),

                //open button ----------------
                ElevatedButton(
                    onPressed: () async {
                      openImage();
                    },
                    child: Text("Open Image")
                ),
              ]
          ),
          actions: [
            TextButton(onPressed: () {
              if (imagepath != '' && imageBytes != Uint8List(0)) {
                Navigator.pop(
                    context, imageBytes);
              }
            }, child: Text("Confirm"))
          ],
        );
      });
  }
}