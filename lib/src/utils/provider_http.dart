import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';

class ProviderHttp {
  //TODO AGREGAR HORARIOS!!!!!
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
    // final response = await _dio.post(
    //     'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
    //     data: {"nombre": "", "codigo": "", "parametro": "2"},
    //     options: Options(contentType: Headers.formUrlEncodedContentType));
    return [];
  }
}
