import 'package:covid19_trace/screens/homescreen.dart';
import 'package:covid19_trace/screens/signup_screen.dart';
import 'package:covid19_trace/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formkey = new GlobalKey<FormState>();
  String email;
  String password;

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
                .signInWithEmailAndPassword(email: email, password: password))
            .user;

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        print('Signed in: ${user.uid}');
      } catch (e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text('Your email id is not registered.Create one'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text(
                        'Sign Up',
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
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('assets/logo.png'), fit: BoxFit.cover)),
              ),
              box(width, height)
            ])),
      ),
    ));
  }

  Widget box(double width, double height) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        width: width / 1.1,
        height: height / 2.5,
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
        ));
  }

  List<Widget> formInputes() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 10),
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
            'Sign in',
            style: TextStyle(color: ColorConstants.subBg),
          )),
      FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            'Don\'t have an account ? Sign Up',
            style: TextStyle(color: ColorConstants.primaryColor),
          )),
    ];
  }
}
