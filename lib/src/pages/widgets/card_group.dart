import 'package:cupos_uis/src/cubit/curso_cubit.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardGroup extends StatelessWidget {
  final Curso curso;
  CardGroup({@required this.curso});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //width: 280,
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
          headerCard(),
          for (Grupo grupo in curso.grupos)
            Column(
              children: <Widget>[
                linea(),
                bodyCard(
                    curso: Curso(
                        codigo: curso.codigo,
                        nombre: curso.nombre,
                        grupos: [grupo]),
                    context: context)
              ],
            )
        ],
      ),
    );
  }

  Widget headerCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          curso.nombre,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          "${curso.codigo}",
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

  Widget bodyCard({Curso curso, BuildContext context}) {
    return InkWell(
      onTap: () {
        _showModalBottomSheet(context, curso);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                var cubit = BlocProvider.of<CursoCubit>(context);
                cubit.toggleFav(cursoToggle: Curso.clone(curso));
              },
              child: Icon(
                Icons.favorite,
                //color: Color(0xffFE7D7D),
                color: curso.grupos[0].fav ? Color(0xffFE7D7D) : Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        curso.grupos[0].nombreGrupo,
                        style: TextStyle(fontWeight: FontWeight.w600),
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
            ),
            Expanded(
              child: Text(
                "${curso.grupos[0].matriculados}/${curso.grupos[0].capacidad}",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color:
                        curso.grupos[0].matriculados < curso.grupos[0].capacidad
                            ? Color(0xff8BC34A)
                            : Color(0xffFE7D7D)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO TERMINAR MODAL!!!
  Future _showModalBottomSheet(BuildContext context, Curso curso) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("20252"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("CALCULO I "),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("GRUPO B1"),
                ),
                Column(
                  children: curso.grupos[0].horarios.map((horario) {
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Profesor: "),
                            Text("pedrito perez")
                          ],
                        )
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          );
        });
  }
}
