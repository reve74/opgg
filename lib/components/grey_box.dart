import 'package:flutter/material.dart';

class GreyBox extends StatelessWidget {
  const GreyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      color: Colors.grey[200],
    );
  }
}
