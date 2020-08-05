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
        grupos =
            parsedJson['grupos'].map((data) => Grupo.fromJson(data)).toList();

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'nombre': nombre,
        'grupos': grupos.map((grupo) => grupo.toJson()).toList()
      };
}
