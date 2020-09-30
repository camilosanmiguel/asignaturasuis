import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:asignaturasuis/src/cubit/search_cubit.dart';
import 'package:asignaturasuis/src/cubit/time_cubit.dart';
import 'package:asignaturasuis/src/models/curso.dart';
import 'package:asignaturasuis/src/utils/preferencias.dart';
import 'package:asignaturasuis/src/utils/provider_http.dart';

class CursoCubit extends Cubit<List<Curso>> {
  static final CursoCubit _instance = CursoCubit._internal();

  factory CursoCubit() {
    return _instance;
  }
  CursoCubit._internal() : super([]) {
    ProviderHttp().init();
    TimeCubit();
  }

  Future<void> update() async {
    List<Curso> cursos;
    if (!SearchCubit().state) {
      cursos = await _getCursos();

      if (cursos.isNotEmpty) {
        TimeCubit().init(
          DateTime.parse(Preferencias().tiempo).difference(DateTime.now()),
        );
        emit(cursos);
        cursos = await ProviderHttp().getCursos(cursos);
        Preferencias().cursos = json.encode(cursos);
        TimeCubit().reset();
      } else {
        Preferencias().tiempo = '';
        TimeCubit().init(Duration(seconds: -1));
      }
      emit(cursos);
    } else {
      cursos = []..addAll(state);
      cursos = await ProviderHttp().getCursos(cursos);
      TimeCubit().reset();
    }
    emit(cursos);
  }

  Future<void> buscar(String query) async {
    TimeCubit().init(Duration(seconds: -1));
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

    TimeCubit().reset();
    emit(cursosHttp);
  }

  Future<void> toggleFav({Curso cursoToggle}) async {
    if (SearchCubit().state) {
      await _toggleShared(cursoToggle);
      List<Curso> cursos = []..addAll(state);

      List<int> index = Curso.getIndex(
          cursos: cursos,
          codigo: "${cursoToggle.codigo}",
          nombregrupo: cursoToggle.grupos[0].nombreGrupo);

      cursos[index[0]].grupos[index[1]].fav =
          !cursos[index[0]].grupos[index[1]].fav;

      emit(cursos);
    } else {
      await _toggleShared(cursoToggle);
      update();
    }
  }

  Future<void> _toggleShared(Curso cursoToggle) async {
    List<Curso> cursos = await _getCursos();

    List<int> index = Curso.getIndex(
        cursos: cursos,
        codigo: "${cursoToggle.codigo}",
        nombregrupo: cursoToggle.grupos[0].nombreGrupo);

    if (cursoToggle.grupos[0].fav) {
      if (cursos[index[0]].grupos.length > 1) {
        cursos[index[0]].grupos.removeAt(index[1]);
      } else {
        cursos.removeAt(index[0]);
      }
    } else {
      if (!index[0].isNegative) {
        cursoToggle.grupos[0].fav = true;
        cursos[index[0]].grupos.add(cursoToggle.grupos[0]);
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
