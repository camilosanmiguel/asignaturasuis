import 'package:cupos_uis/src/models/horario.dart';
import 'package:flutter/widgets.dart';

class Grupo {
  bool fav;
  final String nombreGrupo;
  int capacidad, matriculados;
  List<Horario> horarios;

  Grupo(
      {@required this.fav,
      @required this.nombreGrupo,
      @required this.matriculados,
      @required this.capacidad,
      @required this.horarios});

  Grupo.fromJson(Map<String, dynamic> parsedJson)
      : fav = parsedJson['fav'],
        nombreGrupo = parsedJson['nombreGrupo'],
        capacidad = parsedJson['capacidad'],
        matriculados = parsedJson['matriculados'],
        horarios = (parsedJson['horarios'] as List)
            .map((horario) => Horario.fromJson(horario))
            .toList();

  Map<String, dynamic> toJson() => {
        'fav': fav,
        'nombreGrupo': nombreGrupo,
        'matriculados': matriculados,
        'capacidad': capacidad,
        'horarios': horarios.map((horario) => horario.toJson()).toList()
      };
}
