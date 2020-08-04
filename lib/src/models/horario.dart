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
}
