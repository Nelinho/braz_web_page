import 'package:braz_web_page/braz_web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BrazWebPageWidget',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BrazWebPageWidget(
          page: MyHomePage(title: 'BrazWebPageWidget'),
          loaderWidget: SimpleLoaderWidget(
            circularProgressColor: Colors.white,
            backgroundColor: Colors.black.withOpacity(.8),
          ),
          showSnackbarWhenInternetStatusChange: true,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    // Change default snackbar texts
    BrazWebPageStore().snackBarLabels = SnackBarLabels(offlineText: 'Desconectado!', onlineText: 'Conectado');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          /// You can use [Observer] from [flutter_mobx] to react to internet info and rebuild widgets
          Padding(
            padding: const EdgeInsets.only(right: kFloatingActionButtonMargin),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Observer(builder: (_) {
                bool isConnected = BrazWebPageStore().isOnline.value;
                return isConnected
                    ? Icon(Icons.signal_wifi_4_bar, color: Colors.green)
                    : Icon(Icons.signal_wifi_off, color: Colors.red);
              }),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 16),
            width: size.width > 480 ? 480 : size.width - 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Observer(builder: (_) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: Card(     
                      color: Colors.yellow.shade200,               
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DefaultTextStyle(
                          style: TextStyle(color: Colors.black54, fontSize: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _getRow('CURRENT ROUTE:', '${BrazWebUtils.getCurrentRoute()}'),
                              _getRow('INTERNET CONNECTED:', '${BrazWebPageStore().isOnline.value}'),
                              _getRow('INTERNET INFO:', '${BrazWebUtils.getInternetQualityInfo(BrazWebPageStore().rtt?.value).toString().split('.')[1]} (${BrazWebPageStore().rtt?.value})'),
                              _getRow('HAS QUERY PARAMS:', '${BrazWebUtils.getQueryParams().isNotEmpty}'),
                              _getRow('QUERY PARAMS:', '${BrazWebUtils.getQueryParams()}'),
                              _getRow('SHOW SNACKBAR WHEN CONNECTION CHANGE:', '${BrazWebPageStore().enableSnackbarInternetConnectionMessage}'),
                              _getRow('TAP OUTSIDE TEXTFIELD HIDES KEYBOARD:', 'true'),
                              _getRow('SHOW LOADER WHEN PAGE IS BUSY:', 'true'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 24,),
                TextField(
                  decoration: InputDecoration(
                      helperText:
                          'it loses the focus when taping outside and avoid keyboard panic :)',
                      hintText: 'your text here'),
                ),
                SizedBox(height: 24,),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'SET THIS PAGE AS BUSY FOR 2 SECONDS',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    BrazWebPageStore().setBusy();
                    Future.delayed(Duration(seconds: 2), () {
                      BrazWebPageStore().setIdle();
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getRow(String key, String value){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[Text(key), Text(value)],);
  }
}
