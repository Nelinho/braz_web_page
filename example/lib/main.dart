import 'package:braz_web_page/web_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebPageWidget(
        page: MyHomePage(title: 'Flutter Demo Home Page'),        
      )
    );
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
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(        
          width:size.width > 480 ? 480 : size.width - 32,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintMaxLines: 2,
                  helperText: 'Loose focus when tap outside and avoid keyboard panic :)',
                  hintText: 'your text here'
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('LOAD ALL DATA FROM INTERNET', style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),),
                onPressed: () { 
                  WebPageStore().setBusy();
                  Future.delayed(Duration(seconds: 2), (){
                    WebPageStore().setIdle();
                  });
                 },
              )
            ],
          ),
        ),
      ),
    );
  }
}
