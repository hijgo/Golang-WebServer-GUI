abstract class HomeEvent {}

class CheckAvaiability extends HomeEvent{
  String url;
  CheckAvaiability(this.url);
}

