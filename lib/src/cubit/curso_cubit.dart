import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cupos_uis/src/cubit/search_cubit.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/utils/preferencias.dart';
import 'package:cupos_uis/src/utils/provider_http.dart';

class CursoCubit extends Cubit<List<Curso>> {
  CursoCubit() : super([]);

  Future<void> update() async {
    ProviderHttp().init();
    List<Curso> cursos = await _getCursos();
    TimeCubit().init(Preferencias().tiempo);
    if (cursos.isNotEmpty) {
      cursos = await ProviderHttp().getCursos(cursos);
      Preferencias().cursos = json.encode(cursos);
      print(DateTime.now());
      TimeCubit().reset();
    }
    emit(cursos);
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
    if (SearchCubit().state) {
      await _toggleShared(cursoToggle);
      List<Curso> cursos = []..addAll(state);
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
    } else {
      await _toggleShared(cursoToggle);
      update();
    }
  }

  Future<void> _toggleShared(Curso cursoToggle) async {
    List<Curso> cursos = await _getCursos();
    int indexCurso = -1;
    int indexGrupo;
    cursos.forEach((curso) {
      if (curso.codigo == cursoToggle.codigo) {
        indexCurso = cursos.indexOf(curso);
        curso.grupos.forEach((grupo) {
          if (grupo.nombreGrupo == cursoToggle.grupos[0].nombreGrupo) {
            indexGrupo = curso.grupos.indexOf(grupo);
          }
        });
      }
    });

    if (cursoToggle.grupos[0].fav) {
      if (cursos[indexCurso].grupos.length > 1) {
        cursos[indexCurso].grupos.removeAt(indexGrupo);
      } else {
        cursos.removeAt(indexCurso);
      }
    } else {
      if (indexCurso != -1) {
        cursoToggle.grupos[0].fav = true;
        cursos[indexCurso].grupos.add(cursoToggle.grupos[0]);
      } else {
        cursoToggle.grupos[0].fav = true;
        cursos.add(cursoToggle);
      }
    }
    Preferencias().cursos = json.encode(cursos);
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
