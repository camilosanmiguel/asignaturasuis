import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asignaturasuis/src/cubit/curso_cubit.dart';
import 'package:asignaturasuis/src/models/curso.dart';
import 'package:asignaturasuis/src/models/grupo.dart';
import 'package:asignaturasuis/src/models/horario.dart';

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
                bodyCard(context: context, index: curso.grupos.indexOf(grupo))
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

  Widget bodyCard({BuildContext context, int index}) {
    return InkWell(
      onTap: () {
        _showModalBottomSheet(context, index);
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
                Curso temp = Curso.clone(curso);
                temp.grupos.removeWhere((grupo) =>
                    grupo.nombreGrupo != curso.grupos[index].nombreGrupo);
                cubit.toggleFav(cursoToggle: temp);
              },
              child: Icon(
                Icons.favorite,
                color:
                    curso.grupos[index].fav ? Color(0xffFE7D7D) : Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    curso.grupos[index].nombreGrupo,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: Horario.getProfes(curso.grupos[index].horarios)
                        .map(
                          (profe) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              profe,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                "${curso.grupos[index].matriculados}/${curso.grupos[index].capacidad}",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: curso.grupos[index].matriculados <
                            curso.grupos[index].capacidad
                        ? Color(0xff8BC34A)
                        : Color(0xffFE7D7D)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showModalBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("${curso.codigo}",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(curso.nombre,
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Grupo ${curso.grupos[index].nombreGrupo}",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, bottom: 30),
                  child: Column(
                      children: Horario.getRows(curso.grupos[index].horarios)
                          .map((dato) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Text(dato[0],
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(dato[1],
                                style: TextStyle(fontStyle: FontStyle.italic)),
                          ),
                        ],
                      ),
                    );
                  }).toList()),
                )
              ],
            ),
          );
        });
  }
}
