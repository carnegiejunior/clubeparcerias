//import 'package:clube_parceria_tre_ma/pages/parceiros_screen.dart';
//import 'package:clube_parceria_tre_ma/pages/sobre_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class ClubeParceriaHome extends StatefulWidget {
  @override
  _ClubeParceriaHomeState createState() => new _ClubeParceriaHomeState();
}

class _ClubeParceriaHomeState extends State<ClubeParceriaHome>
    with SingleTickerProviderStateMixin {

  var cachedData = new Map<int, Data>();
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
    var listView = new ListView.builder(
        itemCount: _total,
        itemBuilder: (BuildContext context, int index) {
        Data data = _getData(index);
        return new ListTile(
          title: new Text(data.value),
        );
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Clube de Parcerias'),
        elevation: 4.0,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.more_vert),
            onPressed: () => {},
          ),
        ],
      ),

      body: listView,

      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme
            .of(context)
            .accentColor,
        child: new Icon(Icons.system_update_alt),
        onPressed: () => print('Atualizar lista'),
      ),
    );
  }

  Future<List<Data>> _getDatas(int offset, int limit) async {
    String jsonString = await _getJson(offset, limit);
    //List<Map> list = json.decode(jsonString).cast<Map>();
    List list = json.decode(jsonString) as List;

    var datas = new List<Data>();


//    list.forEach((Map map) => datas.add(new Data.fromMap(map)));
    //list.forEach((element) => datas.add(new Data.fromMap(element as Map)));
    list.forEach((element){
      Map map = element as Map;
      datas.add(new Data.fromMap(map));
    });
    return datas;
  }


  Future<String> _getJson(int offset, int limit) async {
    String jsonString = "[";
    for (int i = offset; i < offset + limit; i++) {
      String id = i.toString();
      String value = "Value($id)";
      jsonString += '{"id":"$id","value":"$value"}';
      if (i < offset + limit - 1) {
        jsonString += ',';
      }
    }
    jsonString += "]";

//    await new Future.delayed(new Duration(seconds: 3));

    return jsonString;
  }

  Data _getData(int index) {
    Data data = cachedData[index];
    if (data == null) {
      int offset = index ~/ 5 * 5;

      if (!offsetLoaded.containsKey(offset)) {
        offsetLoaded.putIfAbsent(offset, () => true);
        _getDatas(offset, 5)
            .then((List<Data> datas) => _updateDatas(offset, datas));
      }
      data = new Data.loading();
    }
    return data;
  }

  Future<int> _getTotal() async {
    return 1000;
  }

  void _updateDatas(int offset, List<Data> datas) {
    setState(() {
      for (int i = 0; i < datas.length; i++) {
        cachedData.putIfAbsent(offset + i, () => datas[i]);
      }
    });
  }


//Simple model called Data
}

class Data {

  String id;
  String value;

  Data.loading(){
    value = "Loading...";
  }

  Data.fromMap(Map map){
    id = map['id'];
    value = map['value'];
  }

}

