import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:memories/screens/dashboard.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserLoginScreen();
  }
}

class UserLoginScreen extends State<Login> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();

  GoogleSignInAccount _currentUser;
  String _contactText;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Login')),
            automaticallyImplyLeading: false,
          ),
          body: getDisplayLoginView()),
    );
  }

  //Below method is used to show Memories App login Screen:-
  getDisplayLoginView() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8, top: 0, right: 8, bottom: 0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                color: Colors.white,
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
                      padding: EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 0),
                      child: TextField(
                        maxLength: 10,
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
                      padding: EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 0),
                      child: TextField(
                        obscureText: true,
                        maxLength: 4,
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
                      padding: EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 16),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
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
                    Padding(
                        padding: EdgeInsets.only(
                            left: 36, top: 16, right: 36, bottom: 16),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Divider(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, top: 0, right: 10, bottom: 0),
                            child: Text("OR",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal)),
                          ),
                          Expanded(
                            child: Divider(),
                          ),
                        ])),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 0, top: 16, right: 0, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonTheme(
                            height: 50,
                            child: RaisedButton.icon(
                              onPressed: () => _facebookLogin(),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              icon: Image.asset('assets/images/facebook.png'),
                              label: Text(
                                'Login via Facebook',
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontStyle: FontStyle.normal),
                              ),
                              textColor: Colors.blue,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 0, right: 0, bottom: 0),
                            child: ButtonTheme(
                              height: 50,
                              child: RaisedButton.icon(
                                onPressed: () => _gmailLogin(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                icon: Image.asset('assets/images/gmail.png'),
                                label: Text(
                                  'Login via Gmail',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.normal),
                                ),
                                textColor: Colors.red,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Below method is used to start login via Facebook:-
  Future<Null> _facebookLogin() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        showToast('''
         Logged in!
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''', Colors.green, Colors.white);
        navigateUser(Dashboard());
        break;
      case FacebookLoginStatus.cancelledByUser:
        showToast('Login cancelled by the user.', Colors.red, Colors.white);
        break;
      case FacebookLoginStatus.error:
        showToast(
            'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${result.errorMessage}',
            Colors.red,
            Colors.white);
        break;
    }
  }

  //Below method is used to make social login via GMAIL:-
  Future<void> _gmailLogin() async {
    try {
      await _googleSignIn
          .signIn()
          .then((value) =>
          showToast(
              'Login Success via a Gmail.', Colors.green, Colors.white))
          .then((value) => navigateUser(Dashboard()));
    } catch (error) {
      print(error);
    }
  }

  //Below method is used to show Toast Message in App:-
  showToast(String validMsg, Color validBackGroundColor, Color validTextColor) {
    Fluttertoast.showToast(
        msg: validMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: validBackGroundColor,
        textColor: validTextColor,
        fontSize: 16.0);
  }

  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });

    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  //Below method is used to sign out user from gmail login:-
  Future<void> _gmailSignOut() => _googleSignIn.disconnect();

  //Below method is used to navigate user to Dashboard Screen:-
  navigateUser(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
