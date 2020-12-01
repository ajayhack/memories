import 'package:flutter/material.dart';

class BottomSheetDialog {
  //region Below Method is used to Show BottomSheet Dialog:-
  showChooser(context, Function(int) bottomChooserCB) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () =>
                          {bottomChooserCB(1), Navigator.of(context).pop()}),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () =>
                        {bottomChooserCB(0), Navigator.of(context).pop()},
                  ),
                ],
              ),
            ),
          );
        });
  }
//endregion
}
