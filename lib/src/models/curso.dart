import 'package:cupos_uis/src/models/grupo.dart';

class Curso {
  final int codigo;
  final String nombre;
  final List<Grupo> grupos;

  Curso(this.codigo, this.nombre, this.grupos);
}
