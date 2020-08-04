import 'package:bloc/bloc.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';

class CursoCubit extends Cubit<List<Curso>> {
  CursoCubit()
      : super(
          [
            Curso(
              nombre: "CALCULO",
              codigo: 2160414,
              grupos: [
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 30,
                    matriculados: 30,
                    horarios: []),
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 20,
                    matriculados: 18,
                    horarios: []),
              ],
            ),
            Curso(
              nombre: "CALCULO",
              codigo: 2160414,
              grupos: [
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 30,
                    matriculados: 30,
                    horarios: []),
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 20,
                    matriculados: 18,
                    horarios: []),
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 20,
                    matriculados: 18,
                    horarios: []),
              ],
            ),
            Curso(
              nombre: "CALCULO",
              codigo: 2160414,
              grupos: [
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 30,
                    matriculados: 30,
                    horarios: []),
              ],
            ),
            Curso(
              nombre: "CALCULO",
              codigo: 2160414,
              grupos: [
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 30,
                    matriculados: 30,
                    horarios: []),
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 20,
                    matriculados: 18,
                    horarios: []),
              ],
            ),
            Curso(
              nombre: "CALCULO",
              codigo: 2160414,
              grupos: [
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 30,
                    matriculados: 30,
                    horarios: []),
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 20,
                    matriculados: 18,
                    horarios: []),
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 20,
                    matriculados: 18,
                    horarios: []),
              ],
            ),
            Curso(
              nombre: "CALCULO",
              codigo: 2160414,
              grupos: [
                Grupo(
                    nombreGrupo: "B1",
                    capacidad: 30,
                    matriculados: 30,
                    horarios: []),
              ],
            ),
          ],
        );

  /// When increment is called, the current state
  /// of the cubit is accessed via `state` and
  /// a new `state` is emitted via `emit`.
  //void increment() => emit([Curso()]);
}
