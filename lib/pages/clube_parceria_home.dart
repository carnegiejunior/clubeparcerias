import 'dart:async';
import 'dart:convert';
import 'package:clube_parceria_tre_ma/pages/clube_parceria_detalhes.dart';
import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:clube_parceria_tre_ma/pages/clube_parceria_localizar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ClubeParceriaHome extends StatefulWidget {
  @override
  _ClubeParceriaHomeState createState() => new _ClubeParceriaHomeState();
}

class _ClubeParceriaHomeState extends State<ClubeParceriaHome> with SingleTickerProviderStateMixin {
  bool _reversedList = false;

  @override
  void initState() {
    super.initState();
  }

  Future<List<PartnerModel>> _getPartnersList() async {
    String jsonString = await rootBundle.loadString('assets/data/partners.json');
    List<Map> list = await json.decode(jsonString).cast<Map>();
    List<PartnerModel> partnerModels = new List<PartnerModel>();
    list.forEach((element) => partnerModels.add(new PartnerModel.fromMap(element)));
    return partnerModels;
  }

  @override
  Widget build(BuildContext context) {

    List<PartnerModel> partnerModelList;

    /_getPartnersList().then((lpm)=>lpm.forEach((pm)=>partnerModelList.add(pm)));

    var _appBarActions = <Widget>[
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ClubeParceriaLocalizar(partnerModels: partnerModelList)),
          );
        },
      ),
/*
      new IconButton(
          icon:  this._reversedList ? new Icon(Icons.arrow_downward) : new Icon(Icons.arrow_upward),
          onPressed:()=>setState(() => this._reversedList = !this._reversedList)
      ),
*/
    ];

    var _appBar = new AppBar(
      title: new Text('Clube de Parcerias'),
      elevation: 4.0,
      centerTitle: false,
      actions: _appBarActions,
    );

    var futureBuilder = new FutureBuilder(
      future: _getPartnersList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Center(
              child: new Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(
                    backgroundColor: Colors.white70,
                  ),
                  new Text('Carregando...'),
                ],
              ),
            );
          default:
            if (snapshot.hasError) {
              return new Text('Error: ${snapshot.error}');
            } else {
              return createListView(context, snapshot, this._reversedList);
            }
        }
      },
    );

    return new Scaffold(
      //drawer: _drawer,
      appBar: _appBar,
      backgroundColor: Color(0xFFFFFFFFFF),
      //body: listView,
      body: futureBuilder,
      //    floatingActionButton: _floatingActionButton,
    );
  }
}

Widget createListView(BuildContext context, AsyncSnapshot<List<PartnerModel>> snapshot, [bool reversed = false]) {
  List<PartnerModel> partnerModels = snapshot.data;

  if (!reversed) {
    partnerModels.sort((a, b) => a.partnerName.trim().compareTo(b.partnerName.trim()));
  } else {
    partnerModels.sort((a, b) => b.partnerName.trim().toLowerCase().compareTo(a.partnerName.trim().toLowerCase()));
  }

  return new ListView.builder(
    itemCount: partnerModels.length,
    itemBuilder: (BuildContext context, int index) {
      return new Card(
        child: new ListTile(
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ClubeParceriaDetalhes(partnerModel: partnerModels[index])),
            );
          },
          leading: new CircleAvatar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey,
            backgroundImage: MemoryImage(base64.decode(partnerModels[index]?.partnerLogo ?? '')),
            child: new Text('SI'),
          ),
          title: new Text(
            partnerModels[index]?.partnerName ?? 'Carregando...',
          ),
          subtitle: new Text(
            partnerModels[index]?.partnerSupertype ?? 'Carregando...',
          ),
        ),
      );
    },
  );
  //values.length;
}
