import 'package:clube_parceria_tre_ma/pages/clube_parceria_home.dart';
import 'package:clube_parceria_tre_ma/pages/clube_parceria_detalhes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clube de Parcerias',
      theme: new ThemeData(
        primaryColor: new Color(0xff0d47a1),
        accentColor: new Color(0xff25D366),
      ),
      home: new ClubeParceriaHome(),
/*
      routes: <String, WidgetBuilder>{
        ClubeParceriaDetalhes.routeName: (context) => ClubeParceriaDetalhes(),
      },
*/
    );
  }
}
