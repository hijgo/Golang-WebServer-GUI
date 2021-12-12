import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gui/Resources/StreamMap/update_stream_map.dart';
import 'package:gui/Resources/auth.dart';
import 'package:gui/screen/event/update_event.dart';
import 'package:http/http.dart';

class UpdateBloC{
  final String _serverUrl = "http://127.0.0.1:4545";
  final String _endpoint = "/webUpdater";
  final Auth _auth = Auth();
  final TextEditingController _destController = TextEditingController();

  String? _fName,_msg,_error;
  Uint8List? _data;
  int? _statusCode,_fSize;

  final _updateStateController = StreamController<UpdateStreamMap>();
  StreamSink<UpdateStreamMap> get _inStreamMap => _updateStateController.sink;
  Stream<UpdateStreamMap> get streamMap => _updateStateController.stream;

  final _updateEventController = StreamController<UpdateEvent>();
  Sink<UpdateEvent> get shopEventSink => _updateEventController.sink;

  UpdateBloC() {
    _updateEventController.stream.listen(_mapEventToState);
  }


  Future<void> _updateWebApp(Uint8List body,String dest) async  {
    Uri url =  Uri.parse(_serverUrl+_endpoint);
    Map<String,String> headers = {"AppName": dest,"x-api-key": _auth.user!.key,"Content-Type": "application/zip"};
    Response response = await post(url,body: body,headers: headers);
    _statusCode = response.statusCode;
    _msg = response.body;
    if(_statusCode != 200){
      _error = _msg;
    }
    _inStreamMap.add(UpdateStreamMap(_statusCode,_msg,_fName,_fSize,_destController,_error));
  }

  void _pickZip() {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.accept = ".zip,application/zip";
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      if(uploadInput.files == null)return;
      final files = uploadInput.files!;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();
        reader.onLoadEnd.listen((e) {
            _fName = file.name;
            _fSize = file.size;
            _data = reader.result as Uint8List?;
            _inStreamMap.add(UpdateStreamMap(_statusCode,_msg,_fName,_fSize,_destController,_error));
        });
        reader.onError.listen((fileEvent) {
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }

  bool _checkIfDestValid(String dest){
    final alphanumeric = RegExp(r'(?!(\/))(^[a-zA-Z-_%\/]+$)');
    return  alphanumeric.hasMatch(dest);
  }

  void _mapEventToState(UpdateEvent event) async {
    if(event is UpdateRequest){
      if (_data == null && _destController.text == "") {
        _error = "destOrDataNull";
        _inStreamMap.add(UpdateStreamMap(_statusCode,_msg,_fName,_fSize,_destController,_error));
        return;
      }
      if(!_checkIfDestValid(_destController.text)){
        _error = "destNotValid";
        _inStreamMap.add(UpdateStreamMap(_statusCode,_msg,_fName,_fSize,_destController,_error));
        return;
      }
      _updateWebApp(_data!, _destController.text);
    }else if (event is PickZip){
      _pickZip();
    }
    _inStreamMap.add(UpdateStreamMap(_statusCode,_msg,_fName,_fSize,_destController,_error));
  }

  void dispose() {
    _updateEventController.close();
    _updateStateController.close();
  }

}