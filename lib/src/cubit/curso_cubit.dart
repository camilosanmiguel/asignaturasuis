import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/utils/preferencias.dart';
import 'package:cupos_uis/src/utils/provider_http.dart';

class CursoCubit extends Cubit<List<Curso>> {
  CursoCubit() : super([]);

  Future<void> update() async {
    ProviderHttp().init();
    List<Curso> cursos = await _getCursos();
    if (cursos.isNotEmpty) {
      List<Curso> cursosHttp = await ProviderHttp().getCursos(cursos);
      //Preferencias().cursos = json.encode(cursosHttp);
      Preferencias().tiempo = 0;
      emit(cursosHttp);
      TimeCubit().reset();
    }
  }

  Future<void> buscar(String query) async {
    ProviderHttp().init();
    TimeCubit().init(-1);
    emit([]);

    List<Curso> cursos = await _getCursos();
    List<Curso> cursosHttp = await ProviderHttp().getCursosByString(query);
    if (cursos.isNotEmpty) {
      cursosHttp.forEach((cursoHttp) {
        cursos.forEach((cursoShared) {
          if (cursoHttp.codigo == cursoShared.codigo) {
            cursoHttp.grupos.forEach((grupoHttp) {
              cursoShared.grupos.forEach((grupoShared) {
                if (grupoShared.nombreGrupo == grupoHttp.nombreGrupo) {
                  grupoHttp.fav = grupoShared.fav;
                }
              });
            });
          }
        });
      });
    }

    emit(cursosHttp);
    TimeCubit().reset();
  }

  Future<void> toggleFav({Curso cursoToggle}) async {
    //TODO PINCHI TOGGLE NO FUNCIONA BIEN :()
    List<Curso> cursos = await _getCursos();
    if (cursos.isEmpty) {
      cursos.add(cursoToggle);
    } else {
      bool agregado = false;
      cursos.forEach((curso) {
        if (curso.codigo == cursoToggle.codigo) {
          curso.grupos.forEach((grupo) {
            if (grupo.nombreGrupo == cursoToggle.grupos[0].nombreGrupo) {
              grupo.fav = !grupo.fav;
              agregado = true;
            }
          });
        }
      });
      if (!agregado) {
        cursos.add(cursoToggle);
      }
    }
    Preferencias().cursos = json.encode(cursos);

    cursos.clear();
    cursos.addAll(state);
    cursos.forEach((curso) {
      if (curso.codigo == cursoToggle.codigo) {
        curso.grupos.forEach((grupo) {
          if (grupo.nombreGrupo == cursoToggle.grupos[0].nombreGrupo) {
            grupo.fav = !grupo.fav;
          }
        });
      }
    });
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
