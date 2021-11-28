import 'dart:async';
import 'package:gui/Resources/StreamMap/login_stream_map.dart';
import 'package:gui/Resources/auth.dart';
import 'package:gui/screen/event/login_event.dart';
import 'package:i18n_plus/i18n.dart';

class LoginBloC{

  LogInState _currentState = LogInState.noChallenge;
  final I18N _i18n = I18N();

  final _logInStateController = StreamController<LogInStreamMap>();
  StreamSink<LogInStreamMap> get _inStreamMap => _logInStateController.sink;
  Stream<LogInStreamMap> get streamMap => _logInStateController.stream;

  final _logInEventController = StreamController<LogInEvent>();
  Sink<LogInEvent> get shopEventSink => _logInEventController.sink;

  LoginBloC() {
    _logInEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LogInEvent event)async {
    if(event is TryToLogin){
      _currentState = await Auth().tryToLogin(event.credential);
    }else if (event is SetLanguage){
      _i18n.setCurrentLocale(event.language);
    }
    _inStreamMap.add(LogInStreamMap(_currentState));
  }

  void dispose() {
    _logInStateController.close();
    _logInEventController.close();
  }

}