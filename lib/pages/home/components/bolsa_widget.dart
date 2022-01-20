import 'package:flutter/material.dart';

class BolsaWidget extends StatelessWidget {
  final Widget child;

  const BolsaWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        // Positioned(
        //   child: Container(
        //     padding: const EdgeInsets.all(2),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.red[200],
        //     ),
        //     constraints: const BoxConstraints(
        //       minHeight: 16,
        //       minWidth: 16,
        //     ),
        //     child: Observer(
        //       name: 'bolsa',
        //       builder: (_) {
        //         return Text(
        //           '${controller.cart!.length}',
        //           textAlign: TextAlign.center,
        //           style: const TextStyle(fontSize: 10, color: Colors.black),
        //         );
        //       },
        //     ),
        //   ),
        //   right: 8,
        //   top: 8,
        // )
      ],
    );
  }
}
