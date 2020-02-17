import 'package:braz_web_page/src/stores/braz_web_page_store.dart';
import 'package:flutter/material.dart';

Widget snackbarDisconnected() => SnackBar(
    duration: Duration(minutes: 1),
    backgroundColor: Colors.red,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(BrazWebPageStore().snackBarLabels.offlineText),
        SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white)))
      ],
    ));

Widget snackbarConnected() => SnackBar(
    duration: Duration(seconds: 2),
    backgroundColor: Colors.green,
    content: new Text(BrazWebPageStore().snackBarLabels.onlineText));
