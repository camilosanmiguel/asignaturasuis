import 'package:flutter/material.dart';
import 'package:cupos_uis/src/pages/widgets/buscar_widget.dart';
import 'package:cupos_uis/src/pages/widgets/card_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.transparent,
                  ),
                ),
                Buscar(),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Color(0xff9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          CardGruop(),
          SizedBox(height: 30),
          CardGruop(),

          //TODO Stream Builder!! Con bloc!!!
          /*Expanded(
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
              )*/
        ],
      )),
    );
  }
}
