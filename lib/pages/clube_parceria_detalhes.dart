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

    Widget titleSection = new Container(
      padding: const EdgeInsets.only(top: 0.0, left: 30.0, right: 32.2, bottom: 0.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  child: new Text(
                    widget.partnerModel.partnerName,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                new Text(
                  widget.partnerModel.partnerProductService,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget discountSection = new Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 0.0, left: 32.0, right: 32.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Icon(
                      Icons.trending_down,
                      color: Colors.green[500],
                    ),
                  ],
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: new Text(
                          widget.partnerModel.partnerDiscount,
                          style: new TextStyle(color: Colors.indigo),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget addressSection = new Container(
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, right: 32.0, left: 32.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Icon(Icons.location_on, color: Colors.green[500]),
                  ],
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: new Text(
                          widget.partnerModel.partnerAddress.trim(),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget emailSection = new Container(
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 32.0, right: 32.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Icon(
                      Icons.email,
                      color: Colors.green[500],
                    ),
                  ],
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: new Text(
                          widget.partnerModel.partnerEmail.trim(),
                          style: new TextStyle(color: Colors.indigo),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget phoneSection = new Container(
      padding: const EdgeInsets.only(top: 0.0, bottom: 10.0, left: 32.0, right: 32.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Icon(
                      Icons.phone,
                      color: Colors.green[500],
                    ),
                  ],
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: new Text(
                          widget.partnerModel.partnerContact.trim(),
                          style: new TextStyle(color: Colors.indigo),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    //final string = 'TRE-MA ';
    return new Scaffold(

      appBar: _appBar,
      backgroundColor: Color(0xFFFFFFFFFF),
      body: new ListView(
        children: [
          new Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: new Image.memory(
              base64.decode(widget.partnerModel.partnerLogo),
              fit: BoxFit.cover,
              height: 140.0,
            ),
          ),
          Divider(),
          titleSection,
          Divider(),
          discountSection,
          Divider(),
          addressSection,
          Divider(),
          emailSection,
          Divider(),
          phoneSection,
        ],
      ),

      persistentFooterButtons: <Widget>[
        new Container(
          child: new Text('TRE-MA, Abril de 2018',),
        ),
      ],
    );
  }
}