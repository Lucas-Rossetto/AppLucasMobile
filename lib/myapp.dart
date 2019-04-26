import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:permission/permission.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RSS Feed',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new PhonePage(),
    );
  }
}


class PhonePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return new PhonePageState();
  }
}

class PhonePageState extends State<PhonePage>{



AndroidIntent intent = AndroidIntent(
  action: 'android.intent.action.CALL',
  data: "tel://0620470408"
);
  _launchURL() async {

    const url = 'tel://0620470408';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  TextInputType phoneNumber = new TextInputType.numberWithOptions();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        padding: EdgeInsets.all(40.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(labelText: "Enter your number here"),
              keyboardType: phoneNumber,
            ),
            new RaisedButton(
              onPressed: () => intent.launch(),
              child: new Icon(Icons.phone),
            )
        
          ],

        )),

    );


  }

}