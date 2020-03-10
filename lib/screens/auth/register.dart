import 'package:flutter/cupertino.dart';

class Register extends StatefulWidget {
  final Function toggleLoginState;
  Register({this.toggleLoginState});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          child: Text('Create Account'),
        ),
        trailing: GestureDetector(
          onTap: () async {
            widget.toggleLoginState();
          },
          child: Text('Login'),
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
                  if (_formKey.currentState.validate()) {
                    print(email);
                    print(password);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
