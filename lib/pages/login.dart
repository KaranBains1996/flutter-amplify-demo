import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LogInPage extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LogInPage> {
  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    try {
      await Amplify.Auth.getCurrentUser();
      Navigator.of(context).pushReplacementNamed('/home');
    } on SignedOutException {
      print('Signed out');
    }
  }

  void signIn() async {
    try {
      SignInResult res = await Amplify.Auth.signInWithWebUI();

      if (res.isSignedIn) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
      // var attribs = await Amplify.Auth.fetchUserAttributes();
      // attribs.forEach((element) {
      //   print('key: ${element.userAttributeKey}; value: ${element.value}');
      // });
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
        child: Center(
          child: Column(
            children: [
              // Text(
              //   'CyDrive',
              //   style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              // ),
              Image(image: AssetImage('assets/cydrive.jpg')),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: SizedBox(
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: signIn,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Ionicons.log_in_outline),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text('Log In'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
