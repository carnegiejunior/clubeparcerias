import 'package:clube_parceria_tre_ma/clube_parceria_home.dart';
import 'package:clube_parceria_tre_ma/data/partner_data_parser.dart';
import 'package:flutter/material.dart';

void main(){
    runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clube de Parcerias',
        theme: new ThemeData(
          primaryColor: new Color(0xff075E54),
          accentColor: new Color(0xff25D366),
        ),
        home: new ClubeParceriaHome(),
    );
  }
}