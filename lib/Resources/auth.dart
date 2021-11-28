
import 'package:gui/Resources/Model/user.dart';
import 'package:gui/Resources/StreamMap/login_stream_map.dart';
import 'package:http/http.dart' as http;

class Auth {
  
  static final Auth _auth = Auth._internal();

  factory Auth() {
    return _auth;
  }

  Auth._internal();

  User? _user;
  User? get user => _user;


  Future<LogInState> _tryToAuthenticate(String credential) async{
    Map<String,String> _headers = <String,String>{"x-api-key": credential};
    http.Response resp = await http.get(Uri.http("192.168.178.22:4545","/statistics"),headers: _headers);
    if(resp.statusCode == 200){
      _user = User(credential);
      return LogInState.succesfulChallenge;
    }
    return LogInState.unSuccesfullChallenge;
  
  }

  Future<LogInState> tryToLogin(String credential) async {
    http.Response resp = await http.get(Uri.http("192.168.178.22:4545","/serverInfo")); 
    if(resp.statusCode != 200){
      return LogInState.notAvailable;
    }else if (resp.statusCode == 200){
      return await _tryToAuthenticate(credential);
    }
    return LogInState.notAvailable;
  }
  
}
