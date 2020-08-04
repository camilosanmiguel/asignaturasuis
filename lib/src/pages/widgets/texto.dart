import 'package:flutter/material.dart';

class Texto extends StatelessWidget {
  const Texto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: Text(
        "No Tienes Ningun Grupo \nGuardado, Dale Click \nEn Buscar",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xff9E9E9E),
        ),
      )),
    );
  }
}
