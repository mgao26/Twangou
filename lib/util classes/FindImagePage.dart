import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class ImageSearchWidget extends StatefulWidget {
  @override
  _ImageSearchWidgetState createState() => _ImageSearchWidgetState();
}

class _ImageSearchWidgetState extends State<ImageSearchWidget> {
  TextEditingController _urlController = TextEditingController();
  List<String> _searchResults = [];
  int selectedImageIndex = -1;
  late double width;
  late double height;

  Future<void> _searchImages() async {
    final apiKey =
        '41837605-a65ab57923c1adc3170be5a59'; // Replace with your Pixabay API key
    final query = _urlController.text;

    if (apiKey.isEmpty || query.isEmpty) {
      return;
    }

    final url =
        'https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo&order=relevant&per_page=50';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final hits = data['hits'] as List<dynamic>;

      setState(() {
        _searchResults =
            hits.map((hit) => hit['webformatURL'].toString()).toList();
      });
    } else {
      // Handle API error
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    // ... (remaining build method code)
    return Scaffold(
        appBar: AppBar(
          title: Text('Search for an Image'),
        ),
        body: Stack(
          children: [
            Column(children: [
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(labelText: 'Enter Search Query'),
              ),
              ElevatedButton(
                onPressed: () {
                  selectedImageIndex = -1;
                  _searchImages();
                },
                child: Text('Search Images'),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Adjust the number of columns as needed
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    return index == selectedImageIndex
                        ? Container(
                            child: GestureDetector(
                                onTap: () => setState(() {
                                      selectedImageIndex = index;
                                    }),
                                child: Image.network(
                                  _searchResults[index],
                                  fit: BoxFit.fill,
                                )),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                          )
                        : GestureDetector(
                            onTap: () => setState(() {
                                  selectedImageIndex = index;
                                }),
                            child: Image.network(
                              _searchResults[index],
                              fit: BoxFit.fill,
                            ));
                  },
                ),
              ),
            ]),
            Positioned(
              bottom: height / 30, // Adjust this value as needed
              left: width / 8, // Adjust this value as needed
              child: Container(
                  width: width * (6 / 8),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selectedImageIndex == -1 ? Colors.red.withOpacity(0.75) : Colors.red, // Set the opacity here
                      ),
                      onPressed: () async {
                        final response = await http.get(Uri.parse(_searchResults[selectedImageIndex]));
                        Uint8List? imageBytes;
                        if (response.statusCode == 200) {
                          setState(() {
                            imageBytes = response.bodyBytes;
                          });
                        }
                        Navigator.pop(
                            context, imageBytes);
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(color: Colors.yellow),
                      ))),
            ),
          ],
        ));

    // ... (remaining build method code)
  }
}
