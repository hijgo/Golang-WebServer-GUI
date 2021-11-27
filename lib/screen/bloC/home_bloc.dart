import 'dart:async';
import 'package:gui/Resources/StreamMap/home_stream_map.dart';
import 'package:gui/screen/event/home_event.dart';

class HomeBloC{
  bool _isAvailable = false;

  final _homeStateController = StreamController<HomeStreamMap>();
  StreamSink<HomeStreamMap> get _inStreamMap => _homeStateController.sink;
  Stream<HomeStreamMap> get streamMap => _homeStateController.stream;

  final _homeEventController = StreamController<HomeEvent>();
  Sink<HomeEvent> get shopEventSink => _homeEventController.sink;

  HomeBloC() {
    _homeEventController.stream.listen(_mapEventToState);
  }

  bool isServerAvaiable(String url){
    return false;
  }

  void _mapEventToState(HomeEvent event)async {
    if(event is CheckAvaiability){
      _isAvailable = isServerAvaiable("");
    }
    _inStreamMap.add(HomeStreamMap(_isAvailable));
  }

  void dispose() {
    _homeEventController.close();
    _homeStateController.close();
  }

}