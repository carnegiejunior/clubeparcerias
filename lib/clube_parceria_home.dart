//import 'package:clube_parceria_tre_ma/pages/parceiros_screen.dart';
//import 'package:clube_parceria_tre_ma/pages/sobre_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ClubeParceriaHome extends StatefulWidget {
  @override
  _ClubeParceriaHomeState createState() => new _ClubeParceriaHomeState();
}

class _ClubeParceriaHomeState extends State<ClubeParceriaHome>
    with SingleTickerProviderStateMixin {
  var cachedPartnerModel = new Map<int, PartnerModel>();
  var offsetLoaded = new Map<int, bool>();
  int _total = 0;

  @override
  void initState() {
    _getTotal().then((int total) {
      setState(() {
        _total = total;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TextStyle textStyle = Theme.of(context).textTheme.display1;

    var listView = new ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      itemCount: _total,
      itemBuilder: (BuildContext context, int index) {

        PartnerModel partnerModel = _getPartnerModel(index);

        return new ListTile(
            //onTap: null,
            isThreeLine: false,
            leading: new CircleAvatar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey,
              child: new Icon(Icons.filter),
              //child: new Image(image: new AssetImage(product.avatarImage)),
            ),
            title: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: new Text(
                    partnerModel.partnerName,
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                    textScaleFactor: 0.9,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            subtitle: new Text(
              partnerModel.partnerActivity,
              style: new TextStyle(
                fontSize: 10.0,
              ),
            ));
      },
    );

    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
              child: new Center(
                  child: new Text(
                'Clube de parcerias - TRE-MA',
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
              decoration: new BoxDecoration(
                color: Colors.green,
                gradient: new LinearGradient(colors: [
                  Colors.green,
                  Colors.lightGreen,
                  Colors.lightGreenAccent,
                ]),
                //image: new DecorationImage(image: new AssetImage("")),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.toc),
              title: new Text('Configurações'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            new ListTile(
              leading: new Icon(Icons.help_outline),
              title: new Text('Sobre o TRE-MA'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: new AppBar(
        title: new Text('Clube de Parcerias'),
        elevation: 4.0,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.filter_list),
            onPressed: (){_ordenar(context);} ,
          ),
        ],
      ),
      body: listView,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Color(0xFFFFFFFF),
        child: new Icon(Icons.cached),
        onPressed: () => print('Atualizar lista'),
      ),
    );
  }

  Future<List<PartnerModel>> _getPartnerModels(int offset, int limit) async {
    String jsonString = await _getJson(offset, limit);
    List<Map> list = json.decode(jsonString).cast<Map>();
    List<PartnerModel> partnerModels = new List<PartnerModel>();
    list.forEach(
        (element) => partnerModels.add(new PartnerModel.fromMap(element)));
    return partnerModels;
  }

  Future<String> _getJson(int offset, int limit) async {
    return rootBundle.loadString('assets/data/partners.json');
  }

  PartnerModel _getPartnerModel(int index) {
    PartnerModel partnerModel = cachedPartnerModel[index];
    if (partnerModel == null) {
      int offset = index ~/ 5 * 5;

      if (!offsetLoaded.containsKey(offset)) {
        offsetLoaded.putIfAbsent(offset, () => true);
        _getPartnerModels(offset, 5).then((List<PartnerModel> partnerModels) =>
            _updatePartnerModels(offset, partnerModels));
      }
      partnerModel = new PartnerModel.loading();
    }
    return partnerModel;
  }

  Future<int> _getTotal() async {
    return 150;
  }

  void _updatePartnerModels(int offset, List<PartnerModel> partnerModels) {
    setState(() {
      for (int i = 0; i < partnerModels.length; i++) {
        cachedPartnerModel.putIfAbsent(offset + i, () => partnerModels[i]);
      }
    });
  }


  Future<Null> _ordenar(BuildContext context) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Filtrar por'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Nome.'),
                new Text('Tipo de instituição.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void ordernar(BuildContext context) {
    new AlertDialog(
          title: new Text('Filtrar por'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Nome.'),
                new Text('Tipo de instituição.'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}
