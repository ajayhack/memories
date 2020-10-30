import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Dashboard extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return DashboardScreen();
  }
}

class DashboardScreen extends State<Dashboard>{
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
          controller: scrollController,
          backgroundColor: Colors.red,
          title: Text('Memories'),
          automaticallyImplyLeading: false),
      body: getDisplayLoginView(),
    );
  }

  //Below method is used to show Memories App login Screen:-
  getDisplayLoginView(){
    return Center(
      child: Text(
        'Login Successfully',
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontSize: 16.0, fontStyle: FontStyle.normal),
      ),
    );
  }
}