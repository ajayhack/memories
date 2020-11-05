import 'package:device_apps/device_apps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memories/screens/dashboard.dart';
import 'package:memories/screens/otpverification.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, top: 16, right: 16, bottom: 0),
                      child: TextField(
                        maxLength: 10,
                        controller: mobileNumberController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Mobile Number',
                            prefixText: "+91",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 16, top: 0, right: 16, bottom: 0),
                      child: Row(children: <Widget>[
                        Icon(Icons.info, color: Colors.black54, size: 15),
                        SizedBox(width: 8.0),
                        Text(
                          'We Will Send One Time Password to this Mobile Number',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                            color: Colors.black54,
                          ),
                        ),
                      ]),
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
                            _sendOTP();
                          },
                          child: Text(
                            'Send OTP',
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
    bool isInstalled = await DeviceApps.isAppInstalled('com.facebook.katana');
    if (isInstalled) {
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
    } else {
      print("Login via Facebook not possible");
    }
  }

  //Below method is used to make social login via GMAIL:-
  Future<void> _gmailLogin() async {
    try {
      signInWithGoogle().then((value) =>
          showToast('Login Success via a Gmail.', Colors.green, Colors.white));
      /*.then((value) => navigateUser(Dashboard()));*/
    } catch (error) {
      print(error);
    }
  }

  //Below method is used to signInWithGoogle using Firebase :-
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    showToast("Name:- " + user.displayName + "\n" + "Email:- " + user.email,
        Colors.green, Colors.white);
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');
      showToast("Name:- " + user.displayName + "\n" + "Email:- " + user.email,
          Colors.green, Colors.white);

      return '$user';
    }

    return null;
  }

  //Below method is used to request OTP from Firebase on the entered number and Navigate user to OTP verification Screen:-
  _sendOTP() {
    if (mobileNumberController.text.isNotEmpty &&
        mobileNumberController.text.length == 10) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPVerification(
                  mobileNumber: mobileNumberController.text,
                )),
      );
    } else {
      showToast("Mobile Number Field Should be a valid 10 Digit Number",
          Colors.red, Colors.white);
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

  //Below method is used to navigate user to Dashboard Screen:-
  navigateUser(Widget screen) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
}
