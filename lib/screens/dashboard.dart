import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memories/screens/login.dart';
import 'package:memories/utils/constant.dart';
import 'package:memories/utils/dialog.dart';
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

  //Below method is used to show Memories App login Screen:-
  _displayMemoriesList() {
    Center(child: Text("Memories Data will be here Soon......"));
  }

  //Below method is to handle bottom navigation onClick:-
  _onBottomNavigationTapped(int index) {
    setState(() {
      if (index == 0) {
        //OnClick of Home.....
        //ToastHelper().showToast("Clicked on Home", Colors.green, Colors.white);
      } else if (index == 1) {
        //OnClick of Add Memories.....
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

  //Below method is used to logout user via a medium by which he/she use to login in:-
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
}
