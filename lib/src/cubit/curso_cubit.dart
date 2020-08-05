import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';
import 'package:cupos_uis/src/utils/preferencias.dart';
import 'package:cupos_uis/src/utils/provider_http.dart';

class CursoCubit extends Cubit<List<Curso>> {
  CursoCubit() : super([]);

  Future<void> update() async {
    ProviderHttp().init();
    List<Curso> cursos = await _getCursos();
    if (cursos.isNotEmpty) {
      //TODO realizarPeticionHTTPConListaCursos
      Preferencias().cursos = json.encode(cursos);
      Preferencias().tiempo = 0;
      emit(cursos);
      TimeCubit().reset();
    }
  }

  Future<void> buscar(String query) async {
    //print(query);
    ProviderHttp().init();
    TimeCubit().init(-1);
    emit([]);
    //List<Curso> cursos = await _getCursos();
    //TODO crearListaCursos-cotejada con la guardada en el shard
    List<Curso> cursosHttp = await ProviderHttp().getCursosByString(query);
    emit(cursosHttp);
    TimeCubit().reset();
  }

  Future<void> toggleFav(Curso curso) async {
    List<Curso> cursos = await _getCursos();

    for (Curso cur in cursos) {
      if (cur.codigo == curso.codigo) {
        for (Grupo gru in cur.grupos) {
          if (gru.nombreGrupo == curso.grupos[0].nombreGrupo) {
            cursos.remove(cur);
            break;
          } else {
            cur.grupos.add(curso.grupos[0]);
            break;
          }
        }
      } else {
        cursos.add(curso);
        break;
      }
    }

    Preferencias().cursos = json.encode(cursos);
    List<Curso> cursosStatus = state;

    emit(cursos);
  }

  Future<List<Curso>> _getCursos() async {
    await Preferencias().init();
    var datos = jsonDecode(Preferencias().cursos);
    List<Curso> cursos = [];
    for (var curso in datos) {
      cursos.add(Curso.fromJson(curso));
    }
    return cursos;
  }
}
