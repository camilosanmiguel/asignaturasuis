import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';
import 'package:cupos_uis/src/models/horario.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

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
    try {
      int cod = int.parse(query);
      codigo = query;
    } catch (e) {
      nombre = query;
    }

    final response = await _dio.post(
        'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
        data: {"nombre": "$nombre", "codigo": "$codigo", "parametro": "2"},
        options: Options(contentType: Headers.formUrlEncodedContentType));

    //TODO ACA Vamos, Falta terminar de parsear la respuesta en modelos de cursos
    var document = parse(response.data);
    print(document.getElementsByTagName('table'));

    return [];
  }

  Future<List<Curso>> getCursos(List<Curso> cursos) async {
    final response = await _dio.post(
        'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
        data: {"nombre": "", "codigo": "", "parametro": "2"},
        options: Options(contentType: Headers.formUrlEncodedContentType));
    return [];
  }
}
