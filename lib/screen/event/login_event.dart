import 'dart:ui';

abstract class LogInEvent {}

class TryToLogin extends LogInEvent {
  String credential;
  TryToLogin(this.credential);
}

class SetLanguage extends LogInEvent {
  Locale language;
  SetLanguage(this.language);
}