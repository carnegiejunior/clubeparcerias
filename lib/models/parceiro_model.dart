//import 'dart:io';
//import 'dart:convert';
//import 'dart:async';

//import 'package:clube_parceria_tre_ma/data/partner_data_parser.dart';


class PartnerModel{

  String partnerName;
  String partnerSupertype;
  String partnerType;
  String partnerAddress;
  String partnerProductService;
  String partnerActivity;
  String partnerEmail;
  String partnerContact;
  String partnerDiscount;
  String partnerLogo;
  int    partnerIdSuperType;
  int    partnerIdType;


  PartnerModel({ // Class' constructor
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

  PartnerModel.loading(){
    this.partnerName = 'Carregando...';
    this.partnerProductService = 'Carregando...';
    this.partnerActivity = 'Carregando...';
  }

  PartnerModel.fromMap(Map map){
    this.partnerIdType = map['idTipo'];
    this.partnerIdSuperType = map['idSuperTipo'];
    this.partnerType = map['nomeTipo'];
    this.partnerName = map['nome'];
    this.partnerAddress = map['endereco'];
    this.partnerContact = map['contato'];
    this.partnerEmail = map['email'];
    this.partnerActivity = map['ramo'];
    this.partnerSupertype = map['educacao'];
    this.partnerDiscount = map['desconto'];
    this.partnerProductService = map['produtoServico'];
  }
}
