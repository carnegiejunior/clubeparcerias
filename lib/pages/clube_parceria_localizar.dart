import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/material.dart';
import 'package:material_search/material_search.dart';

class ClubeParceriaLocalizar extends StatefulWidget {

  final List<PartnerModel> partnerModels;

  ClubeParceriaLocalizar({Key key, this.partnerModels}) : super(key: key);

  @override
  _ClubeParceriaLocalizarState createState() => new _ClubeParceriaLocalizarState();
}

class _ClubeParceriaLocalizarState extends State<ClubeParceriaLocalizar> {

  String _name = 'Nada encontrado';
  //List<PartnerModel> partnerModels = widget.partnerModels.then((pl)=>print(pl));
  //List<String> _names ;
  List<String> _names;

  @override
  void initState(){
    super.initState();
    widget.partnerModels.forEach((p)=>_names.add(p.partnerName));
  }


  //_names.addAll(widget.partnerModels.toList());
  //widget.partnerModels.toList().map((v)=>v.partnerName);

  //static List<PartnerModel> p = widget.partnerModels.toList();
  //.toList().map((p)=>p.partnerName);

  final _formKey = new GlobalKey<FormState>();

  _buildMaterialSearchPage(BuildContext context) {


    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<String>(
              placeholder: 'Localizar',
              results: widget.partnerModels.map((PartnerModel v) =>
              new MaterialSearchResult<String>(
                icon: Icons.person,
                value: v.partnerName,
                text: "${v.partnerName}",
              )).toList(),
              filter: (dynamic value, String criteria) {
                return value.toLowerCase().trim()
                    .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              onSelect: (dynamic value) => Navigator.of(context).pop(value),
            ),
          );
        }
    );
  }

  _showMaterialSearch(BuildContext context) {
    Navigator.of(context)
        .push(_buildMaterialSearchPage(context))
        .then((dynamic value) {
      setState(() => _name = value as String);
    });
  }


  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Localizar parceiro'),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              _showMaterialSearch(context);
            },
            tooltip: 'Search',
            icon: new Icon(Icons.search),
          )
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: new Text("Você encontrou: ${_name ?? 'nada encontrado'}"),
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: new Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    new MaterialSearchInput<String>(
                      placeholder: 'Name',
                      results: _names.map((String v) =>
                      new MaterialSearchResult<String>(
                        icon: Icons.person,
                        value: v,
                        text: "Mr(s). $v",
                      )).toList(),
                      filter: (dynamic value, String criteria) {
                        return value.toLowerCase().trim()
                            .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
                      },
                      onSelect: (dynamic v) {
                        print(v);
                      },
                      validator: (dynamic value) => value == null ? 'Required field' : null,
                      formatter: (dynamic v) => 'Hello, $v',
                    ),
                    new MaterialButton(
                        child: new Text('Validate'),
                        onPressed: () {
                          _formKey.currentState.validate();
                        }
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _showMaterialSearch(context);
        },
        tooltip: 'Search',
        child: new Icon(Icons.search),
      ),
    );
  }
}

