import 'package:flutter/widgets.dart';
import 'package:cupos_uis/src/models/grupo.dart';

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
}
