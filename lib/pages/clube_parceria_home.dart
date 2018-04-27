import 'dart:async';
import 'dart:convert';
import 'package:clube_parceria_tre_ma/pages/clube_parceria_detalhes.dart';
import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
//import 'package:material_search/material_search.dart';

class ClubeParceriaHome extends StatefulWidget {
  @override
  _ClubeParceriaHomeState createState() => new _ClubeParceriaHomeState();
}

class _ClubeParceriaHomeState extends State<ClubeParceriaHome> with SingleTickerProviderStateMixin {
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
    var _drawerHeaderAssetImage = new AssetImage('assets/images/logo.png');
    var _drawerHeaderDecoration = new BoxDecoration(
      color: ThemeData.light().primaryColor,
    );
    var _drawerHeaderChildContainerImage = new Container(
      child: new Center(child: new Image(image: _drawerHeaderAssetImage)),
    );

    //var listDrawerHeader = new ListView(children: <Widget>[],);
    var _drawerHeader = new DrawerHeader(
      child: _drawerHeaderChildContainerImage,
      decoration: _drawerHeaderDecoration,
    );

    var _drawerChildren = [_drawerHeader];
    var _drawerListView = new ListView(children: _drawerChildren);
    var _drawer = new Drawer(
      child: _drawerListView,
    );

    var _floatButtonBackgroundColor = ThemeData.light().accentColor;
    var _floatButtonForegroundColor = new Color(0xFFFFFFFF);
    var _floatButtonIcon = new Icon(Icons.cached);
    var _floatingActionButton = new FloatingActionButton(
      onPressed: () {
        print("teste");
        //this._checkDeviceConnection().then( (bool b) => print(b));
      },
      backgroundColor: _floatButtonBackgroundColor,
      foregroundColor: _floatButtonForegroundColor,
      child: _floatButtonIcon,
    );

    var _appBarActions = <Widget>[
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: () => print(context),
      ),
    ];

    var _appBar = new AppBar(
      title: new Text('Clube de Parcerias'),
      elevation: 4.0,
      centerTitle: true,
      actions: _appBarActions,
    );

    var listView = new ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 18.0),
        itemCount: _total,
        itemBuilder: (BuildContext context, int index) {
          PartnerModel partnerModel = _getPartnerModel(index);
          return new Card(
            child: new ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new ClubeParceriaDetalhes(partnerModel: partnerModel)),
                );
              },
              leading: new CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey,
                backgroundImage: MemoryImage(base64.decode(partnerModel?.partnerLogo ?? '')),
                child: new Text('SI'),
              ),
              title: new Text(
                partnerModel?.partnerName ?? 'Carregando...',
              ),
              subtitle: new Text(
                partnerModel?.partnerSupertype ?? 'Carregando...',
              ),
            ),
          );
        });

    return new Scaffold(
      drawer: _drawer,
      appBar: _appBar,
      backgroundColor: Color(0xFFFFFFFFFF),
      body: listView,
      floatingActionButton: _floatingActionButton,
    );
  }

  // Methods
  Future<List<PartnerModel>> _getPartnerModels(int offset, int limit) async {
    String jsonString = await _getJson(offset, limit);
    List<Map> list = await json.decode(jsonString).cast<Map>();
    List<PartnerModel> partnerModels = new List<PartnerModel>();
    list.forEach((element) => partnerModels.add(new PartnerModel.fromMap(element)));
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
        _getPartnerModels(offset, 5)
            .then((List<PartnerModel> partnerModels) => _updatePartnerModels(offset, partnerModels));
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
}
