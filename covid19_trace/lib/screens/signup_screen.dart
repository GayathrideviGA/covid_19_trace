import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_trace/screens/signin_screen.dart';
import 'package:covid19_trace/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final databaseReference = Firestore.instance;
  final formkey = new GlobalKey<FormState>();
  String email;
  String password;
  String name;
  String phonenumber;
  String userID;
  bool validateForm() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndsubmit() async {
    if (validateForm()) {
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(email: email, password: password))
            .user;
        var firebaseUser = await FirebaseAuth.instance.currentUser();
        Firestore.instance.collection("users").document(firebaseUser.uid).setData({
          "name": name,
          "email": email,
          "password": password,
          "phonenumber": phonenumber,
        }).then((_) {
          print("success!");
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Signed up successfully'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              );
            });
        print('Signed up: ${user.uid}');
        userID = user.uid;
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Your email id is registered.'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              );
            });

        print('Error:$e');
      }
    } else {
      print('Something went wrong');
    }

    setState(() {
      formkey.currentState.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white70, Colors.white70, Colors.white70]),
        ),
        child: SizedBox.expand(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.cover)),
              ),
              Container(
                  width: width / 1.1,
                  height: height / 1.7,
                  decoration: BoxDecoration(
                    color: ColorConstants.background,
                    boxShadow: [BoxShadow(color: ColorConstants.boxshadow, blurRadius: 2)],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: formInputes() + submitButton(),
                    ),
                  ))
            ])),
      ),
    ));
  }

  List<Widget> formInputes() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: 'Enter your name',
              icon: Icon(Icons.account_circle, color: ColorConstants.subBg)),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (value) => name = value,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: 'Enter your Mobile number',
              icon: Icon(Icons.call, color: ColorConstants.subBg)),
          validator: (value) => value.isEmpty ? 'Mobile number can\'t be empty' : null,
          onSaved: (value) => phonenumber = value,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: 'Enter your email address',
              icon: Icon(Icons.person, color: ColorConstants.subBg)),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => email = value,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Enter your passowrd', icon: Icon(Icons.lock, color: ColorConstants.subBg)),
          validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => password = value,
        ),
      )
    ];
  }

  List<Widget> submitButton() {
    return [
      RaisedButton(
          color: ColorConstants.primaryColor,
          onPressed: () {
            validateAndsubmit();
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: ColorConstants.subBg),
          )),
      FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: Text(
            'Already have an account ? Sign In',
            style: TextStyle(color: ColorConstants.primaryColor),
          )),
    ];
  }
}
