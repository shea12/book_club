import 'package:flutter/cupertino.dart';

class SignIn extends StatefulWidget {
  final Function toggleLoginState;
  SignIn({this.toggleLoginState});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemYellow,
        middle: Title(
          color: CupertinoColors.black,
          child: Text('Login'),
        ),
        trailing: GestureDetector(
          onTap: () async {
            widget.toggleLoginState();
          },
          child: Text('Register'),
        ),
      ),
      child: Container(
        color: CupertinoColors.lightBackgroundGray,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20.0),
              CupertinoTextField(
                placeholder: 'Email',
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              CupertinoTextField(
                placeholder: 'Password',
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              CupertinoButton(
                color: CupertinoColors.systemGreen,
                child: Text(
                  'Sign in',
                  style: TextStyle(color: CupertinoColors.white),
                ),
                onPressed: () async {
                  print(email);
                  print(password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
