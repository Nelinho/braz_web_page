import 'package:mobx/mobx.dart';

class WebPageStore {

  WebPageStore._privateConstructor(){
    setBusy = Action(_setBusy);
    setIdle = Action(_setIdle);
  }
  static final WebPageStore _instance = WebPageStore._privateConstructor();
  factory WebPageStore() => _instance;
  
  var status = Observable(WebPageStatus.idle);

  Action setBusy;
  void _setBusy () => status.value = WebPageStatus.busy;
  
  Action setIdle;
  void _setIdle () => status.value = WebPageStatus.idle;
}

enum WebPageStatus {busy, idle}
