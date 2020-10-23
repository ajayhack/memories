import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UserLoginScreen();
  }
}

class UserLoginScreen extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Login'),
          automaticallyImplyLeading: false),
      body: getDisplayLoginView(),
    );
  }

  //Below method is used to show Memories App login Screen:-
  getDisplayLoginView(){
    return Center(
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          doLogin();
        },
        child: Text(
          'Login via Facebook',
          textDirection: TextDirection.ltr,
          style: TextStyle(
              fontSize: 16.0, fontStyle: FontStyle.normal),
        ),
      )
    );
  }

  //Below method is used to start login via Facebook:-
  void doLogin() async{
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        //onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        //onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        //onLoginStatusChanged(true);
        break;
    }
  }
}