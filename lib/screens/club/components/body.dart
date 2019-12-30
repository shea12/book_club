import 'package:flutter/cupertino.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoButton(
        onPressed: () {
          print('Hi Emma I love you!');
        },
        child: Text('Tap Here'),
      ),
    );
  }
}
