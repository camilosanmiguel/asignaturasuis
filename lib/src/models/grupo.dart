import 'package:cupos_uis/src/models/horario.dart';

class Grupo {
  final String nombreGrupo;
  final int capacidad, matriculados;
  final List<Horario> horarios;

  Grupo({this.nombreGrupo, this.capacidad, this.matriculados, this.horarios});

  Grupo.fromJson(Map<String, dynamic> parsedJson)
      : nombreGrupo = parsedJson['nombreGrupo'],
        capacidad = parsedJson['capacidad'],
        matriculados = parsedJson['matriculados'],
        horarios = parsedJson['horarios']
            .map((data) => Horario.fromJson(data))
            .toList();
}
