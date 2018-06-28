import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class ClubeParceriaLocalizar extends StatefulWidget {

  final List<PartnerModel> partnerModels;
  ClubeParceriaLocalizar({Key key, this.partnerModels}) : super(key: key);

  @override
  _ClubeParceriaLocalizarState createState() => new _ClubeParceriaLocalizarState();

}

class _ClubeParceriaLocalizarState extends State<ClubeParceriaLocalizar> {

  SearchBar searchBar;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Bar Demo'),
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _ClubeParceriaLocalizarState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: new Center(
          child: new Text("Don't look at me! Press the search button!")),
    );
  }
}