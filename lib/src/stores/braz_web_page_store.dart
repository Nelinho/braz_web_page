import 'package:connectivity_web/connectivity_web.dart';
import 'package:mobx/mobx.dart';

class BrazWebPageStore {

  BrazWebPageStore._privateConstructor(){

    connectivity = ConnectivityWeb();

    setBusy = Action(_setBusy);
    setIdle = Action(_setIdle);
  }
  static final BrazWebPageStore _instance = BrazWebPageStore._privateConstructor();
  factory BrazWebPageStore() => _instance;

  ConnectivityWeb connectivity;
  
  bool enableSnackbarInternetConnectionMessage = true;
  SnackBarLabels snackBarLabels = SnackBarLabels();

  Observable<WebPageStatus> _status = Observable(WebPageStatus.idle);
  WebPageStatus get status => _status.value;

  Action setBusy;
  void _setBusy () => _status.value = WebPageStatus.busy;
  
  Action setIdle;
  void _setIdle () => _status.value = WebPageStatus.idle;

}

class SnackBarLabels{
  final String onlineText;
  final String offlineText;
  SnackBarLabels({this.onlineText = 'Connected', this.offlineText = 'No internet connection!'});
}

enum WebPageStatus {busy, idle}
