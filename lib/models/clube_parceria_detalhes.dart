import 'dart:convert';

import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/material.dart';

class ClubeParceriaDetalhes extends StatefulWidget {
  static String routeName = '/clubeParceriaDetalhes';

  final PartnerModel partnerModel;

  ClubeParceriaDetalhes({Key key, this.partnerModel}) : super(key: key);

  @override
  _ClubeParceriaDetalhesState createState() => new _ClubeParceriaDetalhesState();
}

class _ClubeParceriaDetalhesState extends State<ClubeParceriaDetalhes> {
  @override
  Widget build(BuildContext context) {

    var _appBar = new AppBar(
      title: new Text('Detalhes do parceiro'),
      elevation: 4.0,
      centerTitle: true,
    );

    Widget addressSection = new Container(
      padding: const EdgeInsets.only(left: 32.0,right: 32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    widget.partnerModel.partnerAddress,
                    style: new TextStyle(
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Divider(),
        ],
      ),
    );

    Widget titleSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    widget.partnerModel.partnerName,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                    ),
                  ),
                ),
                new Text(
                  widget.partnerModel.partnerSupertype,
                ),
              ],
            ),
          ),
/*
          new Icon(
            Icons.star,
            color: Colors.red[500],
          ),
*/
        ],
      ),
    );

    Widget textSection = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        widget.partnerModel.partnerProductService,
        softWrap: true,
      ),
    );

    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Icon(icon, color: color),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.call, 'LIGAR'),
          buildButtonColumn(Icons.near_me, 'ROTA'),
          buildButtonColumn(Icons.share, 'COMPARTILHAR'),
        ],
      ),
    );

    return new Scaffold(
      appBar: _appBar,
      backgroundColor: Color(0xFFFFFFFFFF),
      body: new ListView(
        children: [
          new Image.memory(
            base64.decode(widget.partnerModel?.partnerLogo ?? ''),
            fit: BoxFit.cover,
            height: 240.0,
          ),
          titleSection,
          addressSection,
          buttonSection,
          textSection,
        ],
      ),
    );
  }
}
