class LogInStreamMap {
  LogInState logInState;
  LogInStreamMap(this.logInState);
}

enum LogInState {
  noChallenge,
  notAvailable,
  unSuccesfullChallenge,
  succesfulChallenge
}