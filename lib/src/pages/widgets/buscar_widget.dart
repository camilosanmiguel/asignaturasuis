import 'package:flutter/material.dart';
import 'package:cupos_uis/src/search/search_delegate.dart';

class Buscar extends StatelessWidget {
  const Buscar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: GrupoSearch(hintText: "Busca Un Grupo"),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.centerLeft,
        width: 280,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(0, 5))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Busca Un Grupo",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xff9E9E9E),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
              child: Icon(
                Icons.search,
                size: 20,
                color: Color(0xffD7D7D7),
              ),
              decoration: BoxDecoration(
                color: Color(0xffFE7D7D),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
