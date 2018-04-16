//import 'dart:io';
//import 'dart:convert';
//import 'dart:async';

//import 'package:clube_parceria_tre_ma/data/partner_data_parser.dart';


class PartnerModel{

  final String partnerName;
  final String partnerSupertype;
  final String partnerType;
  final String partnerAddress;
  final String partnerProductService;
  final String partnerActivity;
  final String partnerEmail;
  final String partnerContact;
  final String partnerDiscount;
  final String partnerLogo;
  final int    partnerIdSuperType;
  final int    partnerIdType;


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
}