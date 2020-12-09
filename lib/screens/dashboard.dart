import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memories/screens/addmemories.dart';
import 'package:memories/screens/login.dart';
import 'package:memories/utils/bottomsheet.dart';
import 'package:memories/utils/dialog.dart';
import 'package:memories/utils/enumutils.dart';
import 'package:memories/utils/toast.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardScreen();
  }
}

class DashboardScreen extends State<Dashboard> {
  final scrollController = ScrollController();
  int _selectedIndex = 0;
  ToastHelper toastHelper = new ToastHelper();
  DialogHelper dialogHelper = new DialogHelper();
  BottomSheetDialog bottomSheetDialog = new BottomSheetDialog();
  final databaseReference = FirebaseFirestore.instance;
  Map<String, dynamic> dataMap = Map();
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getMemoriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
          controller: scrollController,
          backgroundColor: Colors.red,
          title: Center(child: Text('Memories')),
          automaticallyImplyLeading: false),
      body: _displayMemoriesList(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text(''),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onBottomNavigationTapped,
      ),
    );
  }

  //region Below method is used to show Memories App login Screen:-
  _displayMemoriesList() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(dataMap.length, (index) {
        return Container(
          child: Card(
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    File(dataMap["imagePath"]),
                    height: 150.0,
                    width: 100.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${dataMap["description"]}',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  //endregion

  //region Below method is to handle bottom navigation onClick:-
  _onBottomNavigationTapped(int index) {
    setState(() {
      if (index == 0) {
        //OnClick of Home.....
        //ToastHelper().showToast("Clicked on Home", Colors.green, Colors.white);
      } else if (index == 1) {
        //OnClick of Add Memories.....
        _openImageChooser();
      } else if (index == 2) {
        //OnClick of Liked Memories.....
      } else {
        dialogHelper.popUpDialog(
            'Are you sure',
            "Do you want to Logout from App?",
            context,
            DialogType.LOGOUT.index,
                () => _logout());
      }
    });
  }

  //endregion

  //region Below method is used to logout user via a medium by which he/she use to login in:-
  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginType = prefs.getInt('loginType');
    print(loginType);
    await FirebaseAuth.instance.signOut().then((value) => {
          prefs.clear(),
          toastHelper.showToast(
              'Logged out successfully', Colors.green, Colors.white),
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          ),
        });
  }

  //endregion

  //region Below method is used to open Image Chooser:-
  _openImageChooser() {
    bottomSheetDialog.showChooser(context, (index) => getImage(index));
  }

  //endregion

  //region Image Chooser From Camera:-
  Future getImage(int index) async {
    print("Camera Started....");
    print(index);
    var pickedFile;
    if (index == 0) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("Image File:- $_image");
        navigateUser(AddMemories(
          pickedImagePath: _image.path,
        ));
      } else {
        print('No image selected.');
      }
    });
  }

  //endregion

  //region Below method is used to navigate user to Add Memories Screen:-
  navigateUser(Widget screen) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );

//endregion

//region Below method is used to get Memories Data:-
  _getMemoriesData() async {
    await databaseReference.collection("Memories").get().then((querySnapshot) =>
        querySnapshot.docs.forEach((result) {
          print(result.data());
          setState(() {
            dataMap = result.data();
          });
        }));
  }
//endregion
}
