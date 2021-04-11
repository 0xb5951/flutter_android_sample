// マテリアルデザインがまとめられてたパッケージをインポート
import 'package:flutter/material.dart';

void main() {
  runApp(SampleApp()); // 引数必須
}

class SampleApp extends StatelessWidget {
  const name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scafold (
        appbar: Appbar(
          title: text('Appbar'),
        ),
        body: Center(
          child: Text('Body'),
        ),
      ),
    );
  }
}