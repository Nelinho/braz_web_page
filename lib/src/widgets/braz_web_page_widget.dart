import 'package:braz_web_page/src/widgets/toast_internet_connection/simple_toast_internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../../braz_web_page.dart';

class BrazWebPageWidget extends StatefulWidget {
  final Widget page;
  final Widget loaderWidget;
  final bool showSnackbarWhenInternetStatusChange;

  BrazWebPageWidget(
      {Key key,
      @required this.page,
      this.loaderWidget,
      this.showSnackbarWhenInternetStatusChange = true})
      : super(key: key);

  @override
  _BrazWebPageWidgetState createState() => _BrazWebPageWidgetState();
}

class _BrazWebPageWidgetState extends State<BrazWebPageWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Dispose _disposeInternetConnectionSubscription;

  @override
  void dispose() {
    _disposeInternetConnectionSubscription();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.showSnackbarWhenInternetStatusChange == true) {
      _disposeInternetConnectionSubscription = BrazWebPageStore()
          .isOnline
          .observe((ChangeNotification<bool> isOnline) {
        if (!BrazWebPageStore().enableSnackbarInternetConnectionMessage) return;
        if (isOnline.newValue == isOnline.oldValue) return;

        if (isOnline.newValue == false) {
          try {
            _scaffoldKey?.currentState?.removeCurrentSnackBar();
            _scaffoldKey?.currentState?.showSnackBar(snackbarDisconnected());
          } catch (e) {}
        } else {
          try {
            _scaffoldKey?.currentState?.removeCurrentSnackBar();
            _scaffoldKey?.currentState?.showSnackBar(snackbarConnected());
          } catch (e) {}
        }
      }, fireImmediately: true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // remove keyboard automatically when user clicks outside textfields (avoiding unexpected behavior with textfields on flutter_web)
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Observer(builder: (_) {
          return Stack(
            children: <Widget>[
              widget.page,
              BrazWebPageStore().status == WebPageStatus.busy
                  ? (this.widget.loaderWidget ?? SimpleLoaderWidget())
                  : Container(),
            ],
          );
        }),
      ),
    );
  }
}
