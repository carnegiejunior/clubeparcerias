import 'dart:async';
import 'package:clube_parceria_tre_ma/models/parceiro_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


Future<String> _loadPartnerDataAsset() async {
  return await rootBundle.loadString('assets/data/partners.json');
}

Future loadPartnerData() async {
  String jsonPartnersData = await _loadPartnerDataAsset();
  return _parseJsonForPartner(jsonPartnersData);
  
}

Future<List<PartnerModel>> _parseJsonForPartner(String jsonString) async {

  Map partnersJSONMap = JSON.decode(jsonString);

  List<PartnerModel> _partnerObj = new List<PartnerModel>();

  for (var partner in partnersJSONMap['root']) {
//    print(partner);
    print(partner['nome']);
     _partnerObj.add(
       new PartnerModel(
                          partnerName: partner['nome'],
                          partnerContact: partner['contato'],
                          partnerEmail: partner['email'],
                        )
                    ); 
  }

  return _partnerObj;

}