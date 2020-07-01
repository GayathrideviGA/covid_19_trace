import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_trace/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BluetoothDevice> bledev = [];

  FlutterBlue flutterBlue = FlutterBlue.instance;
    final databaseReference = Firestore.instance;
    String devicename;
  Future turnOnBTSearching() async {
   
     flutterBlue.scan().listen((scanResult) async{
       print('Started Scanning');
      var device = scanResult.device;
      print(device.id.toString());
      devicename = device.name;
       var firebaseUser = await FirebaseAuth.instance.currentUser();
        Firestore.instance.collection("users").document(firebaseUser.uid).setData({
         "Devicename":devicename
        }).then((_) {
          print("Device adding success!");
        });
      setState(() {
        bledev.add(device);
      });
    });
  }

  @override
  void initState() {
    super.initState();
   bledev.clear();

    turnOnBTSearching();
  }

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: bledev.isEmpty
            ? SizedBox.expand(child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>
              [
                 Container(margin:EdgeInsets.only(bottom: 10),width:150,height:150,decoration:BoxDecoration(image: DecorationImage(image: AssetImage('assets/connection.png'),fit:BoxFit.cover))),
                 Text('No nearby devices found',style: TextStyle(color:ColorConstants.subBg,fontSize: 16),)
              ]
            ))
            : ListView.builder(
                itemCount: bledev.length,
                itemBuilder: (BuildContext cxt, int index) {
                  
                  return ListTile(
                    title: Text(bledev[index].name),
                    subtitle: Text(DateTime.now().toString()),
                    );
                }));
  }
}
