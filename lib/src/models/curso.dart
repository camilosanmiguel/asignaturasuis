import 'package:flutter/widgets.dart';
import 'package:asignaturasuis/src/models/grupo.dart';

class Curso {
  final int codigo;
  final String nombre;
  final List<Grupo> grupos;

  Curso({@required this.codigo, @required this.nombre, @required this.grupos});

  Curso.fromJson(Map<String, dynamic> parsedJson)
      : codigo = parsedJson['codigo'],
        nombre = parsedJson['nombre'],
        grupos = (parsedJson['grupos'] as List)
            .map((grupo) => Grupo.fromJson(grupo))
            .toList();

  Curso.clone(Curso curso)
      : codigo = curso.codigo,
        nombre = curso.nombre,
        grupos = curso.grupos.map((grupo) => Grupo.clone(grupo)).toList();

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nombre': nombre,
        'grupos': grupos.map((grupo) => grupo.toJson()).toList()
      };

  static List<int> getIndex(
      {List<Curso> cursos, String codigo, String nombregrupo = ''}) {
    List<int> codigos = cursos.map((curso) => curso.codigo).toList();
    List<int> index = [];
    index.add(codigos.indexOf(int.parse(codigo)));
    if (!index[0].isNegative) {
      List<String> grupos =
          cursos[index[0]].grupos.map((grupo) => grupo.nombreGrupo).toList();
      index.add(grupos.indexOf(nombregrupo));
    } else {
      index.add(-1);
    }
    return index;
  }
}
