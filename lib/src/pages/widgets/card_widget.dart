import 'package:flutter/material.dart';

class CardGruop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 280,
      decoration: BoxDecoration(
        color: Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(0, 5))
        ],
      ),
      child: Column(
        children: <Widget>[
          headerCard("CALCULO I", "20252"),
          linea(),
          bodyCard(),
          linea(),
          bodyCard(),
        ],
      ),
    );
  }

  Widget headerCard(String nombre, String codigo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          nombre,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          codigo,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget linea() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 0.5,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        //color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(0, 1))
        ],
      ),
    );
  }

  Widget bodyCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xffFE7D7D),
                    //color: Colors.transparent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "B1",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Text(
              "MANUEL FELIPE CERPA TORRES",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        Text(
          "18 / 18",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
