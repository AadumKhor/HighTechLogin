import 'package:flutter/material.dart';
import 'package:high_tech_login/custom_textfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Material App',
        home: Scaffold(
            appBar: AppBar(
              title: Text('High Tech Login'),
            ),
            body: SafeArea(
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
                          
                        },
                        fieldName: 'Username',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextfield(
                        onSubmitted: (String value) {},
                        fieldName: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
