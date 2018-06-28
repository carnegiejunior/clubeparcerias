//import 'dart:io';
//import 'dart:convert';
//import 'dart:async';

//import 'package:clube_parceria_tre_ma/data/partner_data_parser.dart';
import 'package:meta/meta.dart';

class PartnerModel {

  @required String partnerName;
  @required String partnerActivity;
  @required int partnerIdType;
  @required String partnerAddress;
  String partnerSupertype;
  String partnerType;
  String partnerProductService;
  String partnerEmail;
  String partnerContact;
  String partnerDiscount;
  String partnerLogo;
  int partnerIdSuperType;

  PartnerModel({
    // Class' constructor
    this.partnerLogo,
    this.partnerName,
    this.partnerAddress,
    this.partnerType,
    this.partnerContact,
    this.partnerEmail,
    this.partnerActivity,
    this.partnerSupertype,
    this.partnerDiscount,
    this.partnerProductService,
    this.partnerIdSuperType,
    this.partnerIdType,
  });


  PartnerModel.loading() :
    partnerName = 'Carregando...',
    partnerProductService = 'Carregando...',
    partnerActivity = 'Carregando...';

  PartnerModel.fromMap(Map map) {
    this.partnerIdType = map['idTipo'];
    this.partnerIdSuperType = map['idSuperTipo'];
    this.partnerType = map['nomeTipo'];
    this.partnerName = map['nome'];
    this.partnerAddress = map['endereco'];
    this.partnerContact = map['contato'];
    this.partnerEmail = map['email'];
    this.partnerActivity = map['ramo'];
    this.partnerSupertype = map['nomeSuperTipo'];
    this.partnerDiscount = map['desconto'];
    this.partnerProductService = map['produtoServico'];
    this.partnerLogo = map['image'];
  }

  PartnerModel.fromJson(Map json)  :
      partnerName = json['nome'],
      partnerIdType = json['idTipo'],
      partnerIdSuperType = json['idSuperTipo'],
      partnerType = json['nomeTipo'],
      partnerAddress = json['endereco'],
      partnerContact = json['contato'],
      partnerEmail = json['email'],
      partnerActivity = json['ramo'],
      partnerSupertype = json['nomeSuperTipo'],
      partnerDiscount = json['desconto'],
      partnerProductService = json['produtoServico'],
      partnerLogo = json['image'];

}
