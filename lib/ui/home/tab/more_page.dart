import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MoreTabPage extends StatefulWidget {


  @override
  State createState() {
    return MoreTabPageState();
  }
}

class MoreTabPageState extends State<MoreTabPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            child: Text('Permission'),
            textColor: Colors.indigoAccent,
            onPressed: () {
              checkCameraPermission().then((status) {
                if (status == PermissionStatus.granted) {
                  return "already granted permission.";
                } else {
                  return requestCameraPermission();
                }
              }).then((value) {
                final SnackBar snackBar = SnackBar(content: Text(value));
                Scaffold.of(context).showSnackBar(snackBar);
              }).catchError((err) {
                print("error: $err");
              });
            },
          )
        ],
      ),
    );
  }

  Future<PermissionStatus> checkCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    print(cameraPermissionStatus);
    return cameraPermissionStatus;
  }

  Future<String> requestCameraPermission() async {
    Map<PermissionGroup, PermissionStatus> cameraPermissionStatus = await PermissionHandler().requestPermissions([PermissionGroup.camera]);

    cameraPermissionStatus.forEach((group, status) {
      if (group == PermissionGroup.camera) {
        return status.toString();
      }
    });

    return PermissionStatus.unknown.toString();
  }
}