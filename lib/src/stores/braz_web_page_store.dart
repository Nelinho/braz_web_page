import 'dart:html';
import 'dart:async';
import 'package:braz_web_page/src/utils/disposable.interface.dart';
import 'package:mobx/mobx.dart';

class BrazWebPageStore implements IDisposable {

  BrazWebPageStore._privateConstructor(){
    setBusy = Action(_setBusy);
    setIdle = Action(_setIdle);
    changeStatusConnection = Action(_changeStatusConnection);

    _onInternetConnection = window?.navigator?.connection?.onChange;
    if (_onInternetConnection != null) {
      _internetConnectionSubscription = _onInternetConnection
      .listen((event) {
        changeStatusConnection();
      });
    }
    
  }
  static final BrazWebPageStore _instance = BrazWebPageStore._privateConstructor();
  factory BrazWebPageStore() => _instance;
  
  bool enableSnackbarInternetConnectionMessage = true;
  SnackBarConnectionLabels _snackBarInternetConnectionLabels = SnackBarConnectionLabels();
  set snackBarLabels(SnackBarConnectionLabels value) => _snackBarInternetConnectionLabels = value;
  SnackBarConnectionLabels get snackBarLabels => _snackBarInternetConnectionLabels;

  Observable<WebPageStatus> _status = Observable(WebPageStatus.idle);
  WebPageStatus get status => _status.value;

  Stream<Event> _onInternetConnection;
  StreamSubscription<Event> _internetConnectionSubscription;
  Observable<bool> isOnline = Observable(true);
  Observable<int> rtt = Observable(0);

  Action setBusy;
  void _setBusy () => _status.value = WebPageStatus.busy;
  
  Action setIdle;
  void _setIdle () => _status.value = WebPageStatus.idle;

  Action changeStatusConnection;
  void _changeStatusConnection () {
    isOnline.value = window?.navigator?.onLine ?? true;
    rtt.value = window?.navigator?.connection?.rtt;
  }

  @override
  dispose() {
    _internetConnectionSubscription.cancel();
  }
}

class SnackBarConnectionLabels{
  final String onlineText;
  final String offlineText;
  SnackBarConnectionLabels({this.onlineText = 'Connected', this.offlineText = 'No internet connection!'});
}

enum WebPageStatus {busy, idle}
