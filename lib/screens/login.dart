import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return UserLoginScreen();
  }
}

class UserLoginScreen extends State<Login> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _facebookLogin();
              },
              child: Text(
                'Login via Facebook',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontSize: 16.0, fontStyle: FontStyle.normal),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 0, top: 16, right: 0, bottom: 0),
                child: RaisedButton
                  (
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    _gmailLogin();
                  },
                  child: Text(
                    'Login via Gmail',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 16.0, fontStyle: FontStyle.normal),
                  ),
                )
            ),
          ],
        )
    );
  }

  //Below method is used to start login via Facebook:-
  Future<Null> _facebookLogin() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        /*_showMessage('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');*/
        break;
      case FacebookLoginStatus.cancelledByUser:
      //_showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
      /*_showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');*/
        break;
    }
  }

  //Below method is used to make social login via GMAIL:-
  Future<void> _gmailLogin() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

}