import 'package:cupos_uis/src/models/horario.dart';

class Grupo {
  final String nombre;
  final int capacidad, matriculados;
  final List<Horario> horarios;

  Grupo(this.nombre, this.capacidad, this.matriculados, this.horarios);
}
