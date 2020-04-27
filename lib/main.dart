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
            backgroundColor: Color(0xff151F32),
            elevation: 0.0,
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
  TextEditingController userName = new TextEditingController(),
      passWord = new TextEditingController();

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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff151F32), Color(0xff223851)],
                  stops: [0.1, 0.6],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black.withAlpha(230),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(-100, 0),
                            spreadRadius: 10.0,
                            blurRadius: 25.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(100, 0),
                            spreadRadius: 10.0,
                            blurRadius: 25.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 145.0),
                            spreadRadius: 10.0,
                            blurRadius: 25.0),
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -145.0),
                            spreadRadius: 10.0,
                            blurRadius: 25.0)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextfield(
                          bgColor: Colors.transparent,
                          allowBorder: true,
                          borderColor: Colors.white,
                          minWidth: 300.0,
                          controller: userName,
                          onSubmitted: (String value) {
                            print("Username = " + userName.text.trim());
                          },
                          fieldName: 'Username',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextfield(
                          bgColor: Colors.transparent,
                          allowBorder: true,
                          borderColor: Colors.white,
                          minWidth: 300.0,
                          obscureText: true,
                          controller: passWord,
                          onSubmitted: (String value) {
                            print("Pwd = " + passWord.text.trim());
                          },
                          fieldName: 'Password',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomLoginButton(
                            buttonInactiveColor: Colors.transparent,
                            onPressed: () {
                              print(userName.text + passWord.text);
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
