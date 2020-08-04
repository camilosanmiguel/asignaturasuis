import 'package:flutter/material.dart';
import 'package:cupos_uis/src/pages/widgets/buscar.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
