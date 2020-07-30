class Horario {
  final String dia, hora, edificio, profesor;

  Horario(this.dia, this.hora, this.edificio, this.profesor);

  Horario.fromJson(Map<String, dynamic> parsedJson)
      : dia = parsedJson['dia'],
        hora = parsedJson['hora'],
        edificio = parsedJson['edificio'],
        profesor = parsedJson['profesor'];
}
