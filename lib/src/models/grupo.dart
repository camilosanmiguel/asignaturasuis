import 'package:cupos_uis/src/models/horario.dart';
import 'package:flutter/widgets.dart';

class Grupo {
  final String nombreGrupo;
  final int capacidad, matriculados;
  final List<Horario> horarios;

  Grupo(
      {@required this.nombreGrupo,
      @required this.matriculados,
      @required this.capacidad,
      @required this.horarios});

  Grupo.fromJson(Map<String, dynamic> parsedJson)
      : nombreGrupo = parsedJson['nombreGrupo'],
        capacidad = parsedJson['capacidad'],
        matriculados = parsedJson['matriculados'],
        horarios = parsedJson['horarios']
            .map((data) => Horario.fromJson(data))
            .toList();
}
