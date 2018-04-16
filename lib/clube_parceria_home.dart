//import 'package:clube_parceria_tre_ma/pages/parceiros_screen.dart';
//import 'package:clube_parceria_tre_ma/pages/sobre_screen.dart';
import 'package:flutter/material.dart';

class ClubeParceriaHome extends StatefulWidget {
  @override
  _ClubeParceriaHomeState createState() => new _ClubeParceriaHomeState();
}

class _ClubeParceriaHomeState extends State<ClubeParceriaHome>
  with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._tabController =
        new TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
  /*     return new Scaffold(
        appBar: new AppBar(
          title: new Text('Clube de Parcerias TRE-MA'),
          elevation: 0.7,
          bottom: new TabBar(
            controller: this._tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              new Tab(text: "PARCEIROS",),
              new Tab(text: "SOBRE"),
            ],
          ),
          actions: <Widget>[ new IconButton(icon: new Icon(Icons.more_vert),onPressed: null,),
            new Padding(padding: const EdgeInsets.symmetric(horizontal: 5.0),),
            new Icon(Icons.more_vert),],
        ),

        body: new TabBarView(
          controller: this._tabController,
          children: <Widget>[
              new ParceirosScreen(),
              new SobreScreen(),
          ],
          
        ),
        floatingActionButton: new FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            child: new Icon(Icons.system_update_alt),
            onPressed: ()=>print('Atualizar lista'),
          )
      );
    } */


    var _itemCount = 3;

    var listview = new ListView.builder(
      itemCount: _itemCount,
      itemBuilder: (BuildContext context, int index){
        return new ListTile(
          title: new Text("Item"),
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
                             onPressed: ()=>{},
                            ),
                          ],
      ),
      body: listview,
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child: new Icon(Icons.system_update_alt),
          onPressed: ()=>print('Atualizar lista'),
      ),
    );
  }
}