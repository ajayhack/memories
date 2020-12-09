import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories/screens/dashboard.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class AddMemories extends StatefulWidget {
  final String pickedImagePath;

  AddMemories({Key key, @required this.pickedImagePath}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MemoriesPage(pickedImagePath);
  }
}

class MemoriesPage extends State<AddMemories> {
  final descriptionController = TextEditingController();
  final scrollController = ScrollController();
  final databaseReference = FirebaseFirestore.instance;
  String imagePath;

  MemoriesPage(String path) {
    imagePath = path;
    print('Picked Image Path:- $imagePath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        backgroundColor: Colors.red,
        leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  )
                }),
        title: Center(child: Text('Memories')),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check, color: Colors.white),
              onPressed: () => {
                    _createMemories(
                        imagePath, descriptionController.text.toString())
                  })
        ],
      ),
      body: _getDisplayAddMemoriesView(),
    );
  }

  //region Below method is used to show Add Memories View:-
  _getDisplayAddMemoriesView() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.grey.shade300,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image.file(
                      File(imagePath),
                      width: double.infinity,
                    ),
                  ),
                  Text(
                    '${DateTime.now()}',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      controller: descriptionController,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//endregion

//region Below method is used to save memories data:-
  _createMemories(String imagePath, String description) async {
    if (imagePath.isNotEmpty &&
        descriptionController.text
            .toString()
            .isNotEmpty) {
      await databaseReference.collection("Memories").add({
        'imagePath': imagePath,
        'description': description
      }).then((value) =>
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()),)
      );
    } else {
      print("Save Error");
    }
  }
//endregion
}
