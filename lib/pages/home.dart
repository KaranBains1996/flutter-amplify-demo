import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userAttributes = new Map();

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      List<AuthUserAttribute> res = await Amplify.Auth.fetchUserAttributes();

      setState(() {
        res.forEach((element) {
          userAttributes[element.userAttributeKey] = element.value;
          print('key: ${element.userAttributeKey}; value: ${element.value}');
        });
      });
    } on SignedOutException {
      print('Signed out');
    }
  }

  void signOut() async {
    await Amplify.Auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
        child: Center(
          child: Column(
            children: [
              Text('Welcome ${userAttributes['name'] ?? ''}'),
              Container(
                  margin: EdgeInsets.only(top: 120.0),
                  child: ElevatedButton(
                      onPressed: signOut, child: Text('Sign out')))
            ],
          ),
        ),
      ),
    );
  }
}
