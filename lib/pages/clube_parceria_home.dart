import 'dart:async';
import 'dart:convert';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:clube_parceria_tre_ma/pages/clube_parceria_detalhes.dart';
import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ClubeParceriaHome extends StatefulWidget {

  ClubeParceriaHome({Key key}) : super(key: key);

  @override
  _ClubeParceriaHomeState createState() => new _ClubeParceriaHomeState();

}

class _ClubeParceriaHomeState extends State<ClubeParceriaHome> with SingleTickerProviderStateMixin {

  SearchBar _searchBar;

  bool _reversedList = false;

  final _edtController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<List<PartnerModel>> _fp;

  AppBar buildAppBar(BuildContext context) {

    return new AppBar(
        title: new Text('Clube de Parcerias'),
        elevation: 6.0,
        centerTitle: false,
        actions: [
          _searchBar.getSearchAction(context),
        ],

    );
  }


  void _printLatestValue() {
    setState(() {
        this._fp = _getPartnersList(_edtController.text);
    });

  }

  void message(String value){
    setState(() => _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('$value'))));
  }


  @override
  void initState() {
    super.initState();
    this._edtController.addListener(_printLatestValue);
    this._fp = _getPartnersList("");
  }

  @override
  void dispose() {
    _edtController.removeListener(_printLatestValue);
    _edtController.dispose();
    super.dispose();
  }

  void onSubmitted(String value) {
    //setState(() => _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  void onChanged(String value) {
    setState(() {
      this._fp = _getPartnersList(_edtController.text);
    });
  }

  _ClubeParceriaHomeState() {

    _searchBar = new SearchBar(
      inBar: false,
      showClearButton: true,
      closeOnSubmit: false,
      clearOnSubmit: false,
      hintText: 'Nome do parceiro',
      setState: setState,
      onSubmitted: onSubmitted,
      buildDefaultAppBar: buildAppBar,
      onChanged:onChanged,
      controller: _edtController,

    );
  }

  Future<List<PartnerModel>> _getPartnersList(final String k) async {

    String jsonString = await rootBundle.loadString('assets/data/partners.json');
    List<PartnerModel> partnerModels = new List<PartnerModel>();
    List<Map> list = await json.decode(jsonString).cast<Map>();
    list.forEach((element) => partnerModels.add(new PartnerModel.fromMap(element)));

    return partnerModels.where((element) =>
          element.partnerName.toLowerCase().contains(new RegExp(".*(${k.toLowerCase()}).*")))
          .toList();
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _fp,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(
                    backgroundColor: Colors.white70,
                  ),
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
      appBar: _searchBar.build(context),
      key: _scaffoldKey,
      backgroundColor: Color(0xF5F5F5F5),
      body: new Container(
        margin: EdgeInsets.all(6.0),
        //padding: EdgeInsets.only(top: 2.0, right: 6.0,left: 6.0),
        child: futureBuilder,
      ),
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
                 builder: (context) => new ClubeParceriaDetalhes(partnerModel: partnerModels[index]),
              ),

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
          //trailing: new Text("TTT"),


        ),
      );
    },
  );
  //values.length;
}
