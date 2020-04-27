import 'package:flutter/material.dart';
import 'package:high_tech_login/animated_login_button.dart';
import 'package:high_tech_login/custom_textfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: Text('High Tech Login'),
          ),
          body: LoginPage()),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = "", passWord = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.blueGrey[700],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  onSubmitted: (String value) {
                    setState(() {
                      userName = value.trim();
                    });
                  },
                  fieldName: 'Username',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextfield(
                  onSubmitted: (String value) {
                    setState(() {
                      passWord = value.trim();
                    });
                  },
                  fieldName: 'Password',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomLoginButton(
                    buttonInactiveColor: Colors.transparent,
                    onPressed: () {
                      print('Button Pressed');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
