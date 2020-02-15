import 'package:flutter/material.dart';

class SimpleLoaderWidget extends StatelessWidget {
  
  final Color circularProgressColor;
  final Color backgroundColor;
  final Widget progressIndicationWidget;

  const SimpleLoaderWidget({
    Key key, 
    this.circularProgressColor = Colors.white, 
    this.backgroundColor = Colors.black26,
    this.progressIndicationWidget
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(dismissible: false, color: this.backgroundColor),
        this.progressIndicationWidget ?? Center(child: new CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(this.circularProgressColor),
        ),),
      ],
    );
  }
}