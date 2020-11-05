import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPVerification extends StatefulWidget {
  final String mobileNumber;

  OTPVerification({Key key, @required this.mobileNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OTP(mobileNumber);
  }
}

class OTP extends State<OTPVerification> {
  String number = "";

  OTP(String mobileNumber) {
    number = mobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primaryColor: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('Login'))),
        body: _getOTPView(),
      ),
    );
  }

  //Below method is used to render OTP View:-
  _getOTPView() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.grey.shade300,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Image.asset(
                    "assets/images/memories.png",
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Text(
                      "Enter the 4 Digit OTP which is send on +91" +
                          number +
                          "Number",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.black54,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 0, right: 16),
                  child: OTPTextField(
                    length: 4,
                    width: 120,
                    fieldWidth: 8,
                    keyboardType: TextInputType.number,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    style: TextStyle(fontSize: 14),
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      print("Completed: " + pin);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
