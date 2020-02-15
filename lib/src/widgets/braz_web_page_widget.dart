import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../braz_web_page.dart';

class BrazWebPageWidget extends StatelessWidget {
  
  final Widget page;
  final Widget loaderWidget;
  const BrazWebPageWidget({Key key, @required this.page, this.loaderWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // remove keyboard automatically when user clicks outside textfields (avoiding unexpected behavior with textfields)
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Observer(builder: (_) {
        return Stack(
          children: <Widget>[
            page,
            BrazWebPageStore().status.value == WebPageStatus.busy
                ? (this.loaderWidget ?? SimpleLoaderWidget())
                : Container()
          ],
        );
      }),
    );
  }
}
