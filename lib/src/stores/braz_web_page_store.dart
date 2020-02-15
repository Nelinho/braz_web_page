import 'package:mobx/mobx.dart';

class BrazWebPageStore {

  BrazWebPageStore._privateConstructor(){
    setBusy = Action(_setBusy);
    setIdle = Action(_setIdle);
  }
  static final BrazWebPageStore _instance = BrazWebPageStore._privateConstructor();
  factory BrazWebPageStore() => _instance;
  
  var status = Observable(WebPageStatus.idle);

  Action setBusy;
  void _setBusy () => status.value = WebPageStatus.busy;
  
  Action setIdle;
  void _setIdle () => status.value = WebPageStatus.idle;
}

enum WebPageStatus {busy, idle}
