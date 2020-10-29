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
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();

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
        Padding(
          padding: EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
          child: Card(
            color: Colors.white,
            elevation: 10.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Memories',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
                  child: TextField(
                    maxLength: 50,
                    controller: mobileNumberController,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 0),
                  child: TextField(
                    obscureText: true,
                    maxLength: 20,
                    controller: otpController,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'OTP',
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        //doLogin();
                      },
                      child: Text(
                        'Login',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 16.0, fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          child: Text(
            'or',
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
                color: Colors.grey),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0, top: 16, right: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                elevation: 10,
                onPressed: () => _facebookLogin(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                icon: Image.asset('assets/images/facebook.png'),
                label: Text(
                  'Login via Facebook',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),
                ),
                textColor: Colors.blue,
                splashColor: Colors.red,
                color: Colors.white,
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 16, top: 0, right: 0, bottom: 0),
                  child: RaisedButton.icon(
                    elevation: 10,
                    onPressed: () => _gmailLogin(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    icon: Image.asset('assets/images/gmail.png'),
                    label: Text(
                      'Login via Gmail',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          fontSize: 16.0, fontStyle: FontStyle.normal),
                    ),
                    textColor: Colors.red,
                    splashColor: Colors.red,
                    color: Colors.white,
                  )),
            ],
          ),
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