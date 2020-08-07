import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';
import 'package:cupos_uis/src/models/horario.dart';

//TODO AGREGAR HORARIOS!!!!!
class ProviderHttp {
  static final ProviderHttp _instance = ProviderHttp._ctor();
  factory ProviderHttp() {
    return _instance;
  }

  ProviderHttp._ctor();
  Dio _dio;

  init() {
    _dio = Dio();
    _dio.options.headers["Host"] = 'www.uis.edu.co';
    _dio.options.headers["Content-Type"] = 'application/x-www-form-urlencoded';
    _dio.options.headers["Content-Length"] = '32';
    _dio.options.headers["Origin"] = 'https://www.uis.edu.co';
  }

  Future<List<Curso>> getCursosByString(String query) async {
    String codigo = '';
    String nombre = '';
    String parametro = '';

    try {
      int.parse(query);
      codigo = query;
      parametro = '2';
    } catch (e) {
      nombre = query;
      parametro = '1';
    }

    final response = await _dio.post(
        'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
        data: {
          "nombre": "$nombre",
          "codigo": "$codigo",
          "parametro": "$parametro"
        },
        options: Options(contentType: Headers.formUrlEncodedContentType));

    var document = parse(response.data);
    var tablas = document.getElementsByClassName('tabla');

    List<Curso> cursosHttp = [];

    for (Element tabla in tablas) {
      var filas = tabla.getElementsByTagName("tr");

      var nombre = filas[0].getElementsByTagName("td")[0].text.trim();
      var codigo = filas[0]
          .getElementsByTagName("td")[1]
          .text
          .split(':')[1]
          .replaceAll(new RegExp(r"\s+"), "");
      var nombregrupo = filas[1]
          .getElementsByTagName("td")
          .first
          .text
          .split(':')[1]
          .replaceAll(new RegExp(r"\s+"), "");
      var capacidad = filas[2]
          .getElementsByTagName("td")[0]
          .text
          .split(':')[1]
          .replaceAll(new RegExp(r"\s+"), "");
      var matriculados = filas[2]
          .getElementsByTagName("td")[1]
          .text
          .split(':')[1]
          .replaceAll(new RegExp(r"\s+"), "");

      bool agregado = false;

      if (cursosHttp.isNotEmpty) {
        cursosHttp.forEach((element) {
          if (element.codigo == int.parse(codigo)) {
            element.grupos.add(
              Grupo(
                  fav: false,
                  nombreGrupo: nombregrupo,
                  matriculados: int.parse(matriculados),
                  capacidad: int.parse(capacidad),
                  horarios: []),
            );
            agregado = true;
          }
        });
        if (!agregado) {
          cursosHttp.add(
            Curso(nombre: nombre, codigo: int.parse(codigo), grupos: [
              Grupo(
                fav: false,
                nombreGrupo: nombregrupo,
                matriculados: int.parse(matriculados),
                capacidad: int.parse(capacidad),
                horarios: [],
              )
            ]),
          );
        }
      } else {
        cursosHttp.add(
          Curso(nombre: nombre, codigo: int.parse(codigo), grupos: [
            Grupo(
              fav: false,
              nombreGrupo: nombregrupo,
              matriculados: int.parse(matriculados),
              capacidad: int.parse(capacidad),
              horarios: [],
            )
          ]),
        );
      }
    }
    return cursosHttp;
  }

  Future<List<Curso>> getCursos(List<Curso> cursos) async {
    print("cursos que llegan al get cursos");
    print(json.encode(cursos));

    List codigos = cursos.map((curso) => curso.codigo).toList();
    for (int codigo in codigos) {
      final response = await _dio.post(
          'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
          data: {"nombre": "", "codigo": "$codigo", "parametro": "2"},
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var document = parse(response.data);
      var tablas = document.getElementsByClassName('tabla');
      for (Element tabla in tablas) {
        var filas = tabla.getElementsByTagName("tr");

        var nombregrupo = filas[1]
            .getElementsByTagName("td")
            .first
            .text
            .split(':')[1]
            .replaceAll(new RegExp(r"\s+"), "");

        var capacidad = filas[2]
            .getElementsByTagName("td")[0]
            .text
            .split(':')[1]
            .replaceAll(new RegExp(r"\s+"), "");

        var matriculados = filas[2]
            .getElementsByTagName("td")[1]
            .text
            .split(':')[1]
            .replaceAll(new RegExp(r"\s+"), "");
        //TODO SACARLO DEL FOREACH
        print("inicio");
        await cursos.forEach((curso) async {
          if (curso.codigo == codigo) {
            await curso.grupos.forEach((grupo) async {
              if (grupo.nombreGrupo == nombregrupo) {
                grupo.capacidad = int.parse(capacidad);
                grupo.matriculados = int.parse(matriculados);
                grupo.horarios =
                    await _getHorarios(codigo, nombregrupo, curso.nombre);
              }
            });
          }
        });
        print("fin");
      }
    }
    return cursos;
  }

  Future<List<Horario>> _getHorarios(
      int codigo, String nombreGrupo, String nombre) async {
    List<Horario> horarios = [];
    final response = await Dio().get(
      'https://www.uis.edu.co/estudiantes/asignaturas_programadas/horario_asignatura.jsp?codigo=$codigo&grupo=$nombreGrupo&nombre=$nombre',
    );
    var document = parse(response.data);
    var tablas = document.getElementsByClassName('tabla_letra12');
    print(tablas);
    return horarios;
  }
}
