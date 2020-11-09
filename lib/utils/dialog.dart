import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories/utils/constant.dart';

class DialogHelper {
  //Below method is used to show OTP Dialog and Verify it from Firebase:-
  popUpDialog(String titleText, String message, BuildContext context, int type,
      Function positiveButtonCB) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text(titleText),
              content: Text(
                message,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  color: Colors.black54,
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text("NO"),
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                ),
                RaisedButton(
                  child: Text("YES"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () => {
                    if (type == DialogType.LOGOUT.index)
                      {Navigator.pop(context), positiveButtonCB}
                    else if (type == DialogType.EXIT.index)
                      {SystemNavigator.pop()}
                  },
                )
              ],
            ));
  }
}
