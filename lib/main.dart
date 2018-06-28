import 'package:clube_parceria_tre_ma/pages/clube_parceria_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clube de Parcerias',
      theme: ThemeData.light(),
      home: new ClubeParceriaHome(),
    );
  }
}
