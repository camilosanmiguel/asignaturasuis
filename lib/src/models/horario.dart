import 'package:flutter/widgets.dart';

class Horario {
  final String dia, hora, edificio, profesor;

  Horario(
      {@required this.dia,
      @required this.hora,
      @required this.edificio,
      @required this.profesor});

  Horario.fromJson(Map<String, dynamic> parsedJson)
      : dia = parsedJson['dia'],
        hora = parsedJson['hora'],
        edificio = parsedJson['edificio'],
        profesor = parsedJson['profesor'];

  Horario.clone(Horario horario)
      : dia = horario.dia,
        hora = horario.hora,
        edificio = horario.edificio,
        profesor = horario.profesor;

  Map<String, dynamic> toJson() =>
      {'dia': dia, 'hora': hora, 'edificio': edificio, 'profesor': profesor};

  static List<String> getProfes(List<Horario> horarios) {
    List<String> profe = [];
    horarios.forEach(
      (horario) {
        if (!profe.contains(horario.profesor)) profe.add(horario.profesor);
      },
    );
    return profe;
  }

  static List<List<String>> getRows(List<Horario> horarios) {
    List<List<String>> rows = [];
    List<String> profes = getProfes(horarios);
    if (profes.length == 0) {
      rows.add(["Profesor", profes[0]]);
      for (Horario horario in horarios) {
        rows.add(["${horario.dia}", "${horario.edificio}"]);
      }
    } else {
      String temp;
      for (Horario horario in horarios) {
        if (temp != null) {
          if (horario.profesor != temp) {
            rows.add(["Profesor:", "${horario.profesor}"]);
            temp = horario.profesor;
          }
        } else {
          rows.add(["Profesor:", "${horario.profesor}"]);
          temp = horario.profesor;
        }
        rows.add(["${horario.dia}:", "${horario.hora} ${horario.edificio}"]);
      }
    }
    return rows;
  }
}
