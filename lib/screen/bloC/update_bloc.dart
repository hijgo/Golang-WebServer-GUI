import 'dart:async';
import 'dart:typed_data';
import 'package:gui/Resources/StreamMap/update_stream_map.dart';
import 'package:gui/Resources/auth.dart';
import 'package:gui/screen/event/update_event.dart';
import 'package:http/http.dart';

class UpdateBloC{
  final String _serverUrl = "http://127.0.0.1:4545";
  final String _endpoint = "/webupdater";
  final Auth _auth = Auth();

  int? _statusCode;
  String? _msg;

  final _updateStateController = StreamController<UpdateStreamMap>();
  StreamSink<UpdateStreamMap> get _inStreamMap => _updateStateController.sink;
  Stream<UpdateStreamMap> get streamMap => _updateStateController.stream;

  final _updateEventController = StreamController<UpdateEvent>();
  Sink<UpdateEvent> get shopEventSink => _updateEventController.sink;

  UpdateBloC() {
    _updateEventController.stream.listen(_mapEventToState);
  }


  void updateWebApp(Uint8List body,String dest) async  {
    Uri url =  Uri.parse(_serverUrl+_endpoint);
    Map<String,String> headers = {"AppName":dest,"x-api-key": _auth.user!.key,"Content-Type": "application/zip"};
    Response response = await post(url,body: body,headers: headers);
    _statusCode = response.statusCode;
    _msg = response.body;
  }

  void _mapEventToState(UpdateEvent event) async {
    if(event is UpdateRequest){
    }
    _inStreamMap.add(UpdateStreamMap(_statusCode,_msg));
  }

  void dispose() {
    _updateEventController.close();
    _updateStateController.close();
  }

}