import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories/screens/dashboard.dart';

class AddMemories extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemoriesPage();
  }
}

class MemoriesPage extends State<AddMemories> {
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              onPressed: () => {print("Memories Data Saved")})
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
            padding: EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 0),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.grey.shade300,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/memories.png",
                        height: 60,
                        width: 60,
                      )),
                  Text(
                    '01 Dec 2020',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 0),
                    child: TextField(
                      maxLength: 10,
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
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, top: 0, right: 0, bottom: 0),
                    child: ButtonTheme(
                      height: 50,
                      child: RaisedButton.icon(
                        onPressed: () => {},
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        icon: Icon(Icons.check),
                        label: Text(
                          'Submit',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 16.0, fontStyle: FontStyle.normal),
                        ),
                        textColor: Colors.red,
                        color: Colors.white,
                      ),
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
}
