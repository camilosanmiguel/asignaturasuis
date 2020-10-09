import 'package:flutter/material.dart';

class Texto extends StatelessWidget {
  final String texto;
  const Texto({Key key, this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xff9E9E9E),
          ),
        ),
      ),
    );
  }
}
