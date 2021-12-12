import 'package:flutter/material.dart';

class UpdateStreamMap {
  int? statusCode,fSize;
  String? msg,fName,error;
  TextEditingController destController;
  UpdateStreamMap(this.statusCode,this.msg,this.fName,this.fSize,this.destController,this.error);
}