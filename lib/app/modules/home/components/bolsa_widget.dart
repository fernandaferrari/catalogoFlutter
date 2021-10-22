import 'package:flutter/material.dart';

class BolsaWidget extends StatelessWidget {
  final Widget child;
  final String value;

  BolsaWidget({
    required this.child,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red[200],
            ),
            constraints: BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
          ),
          right: 8,
          top: 8,
        )
      ],
    );
  }
}
