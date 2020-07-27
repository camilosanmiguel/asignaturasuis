import 'package:flutter/material.dart';
import 'package:cupos_uis/src/pages/widgets/buscar_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Buscar(),
            ),
            //TODO Stream Builder!! Con bloc!!!
            Expanded(
              child: Center(
                child: Text(
                  "No Tienes Ningun Grupo \nGuardado, Dale Click \nEn Buscar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff9E9E9E),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
