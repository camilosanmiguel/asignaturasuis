import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:cupos_uis/src/models/curso.dart';
import 'package:cupos_uis/src/models/grupo.dart';
import 'package:cupos_uis/src/models/horario.dart';

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

    List<Curso> cursosHttp = [];

    try {
      Response response = await _dio.post(
          'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
          data: {
            "nombre": "$nombre",
            "codigo": "$codigo",
            "parametro": "$parametro"
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      Document document = parse(response.data);
      List<Element> tablas = document.getElementsByClassName('tabla');

      for (Element tabla in tablas) {
        List<Element> filas = tabla.getElementsByTagName("tr");
        List<String> datos = _scrapCursos(filas);

        String nombre = datos[0];
        String codigo = datos[1];
        String nombregrupo = datos[2];
        String capacidad = datos[3];
        String matriculados = datos[4];

        List<Horario> horarios = [];
        try {
          Response response = await Dio().get(
            'https://www.uis.edu.co/estudiantes/asignaturas_programadas/horario_asignatura.jsp?codigo=$codigo&grupo=$nombregrupo&nombre=$nombre',
          );
          Document document = parse(response.data);
          List<Element> tablas =
              document.getElementsByClassName('tabla_letra12');
          tablas = tablas.getRange(1, tablas.length).toList();
          for (Element tabla in tablas) {
            List<Element> filas = tabla.getElementsByTagName("tr");
            List<String> datos = _scrapHorarios(filas);

            String dia = datos[0];
            String hora = datos[1];
            String edificio = datos[2];
            String profesor = datos[3];

            Horario horario = Horario(
                dia: dia, hora: hora, edificio: edificio, profesor: profesor);
            horarios.add(horario);
          }
        } catch (e) {
          print(e);
        }

        int indexCurso = Curso.getIndex(cursos: cursosHttp, codigo: codigo)[0];

        Curso curso = Curso(nombre: nombre, codigo: int.parse(codigo), grupos: [
          Grupo(
            fav: false,
            nombreGrupo: nombregrupo,
            matriculados: int.parse(matriculados),
            capacidad: int.parse(capacidad),
            horarios: horarios,
          )
        ]);

        if (indexCurso > 0) {
          cursosHttp[indexCurso].grupos.add(curso.grupos[0]);
        } else {
          cursosHttp.add(curso);
        }
      }
    } catch (e) {
      print(e);
    }
    return cursosHttp;
  }

  Future<List<Curso>> getCursos(List<Curso> cursos) async {
    List codigos = cursos.map((curso) => curso.codigo).toList();

    for (int codigo in codigos) {
      try {
        Response response = await _dio.post(
            'https://www.uis.edu.co/estudiantes/asignaturas_programadas/resultado_buscador.jsp',
            data: {"nombre": "", "codigo": "$codigo", "parametro": "2"},
            options: Options(contentType: Headers.formUrlEncodedContentType));
        Document document = parse(response.data);
        List<Element> tablas = document.getElementsByClassName('tabla');

        for (Element tabla in tablas) {
          List<Element> filas = tabla.getElementsByTagName("tr");
          List<String> datos = _scrapCursos(filas);

          String nombre = datos[0];
          String codigo = datos[1];
          String nombregrupo = datos[2];
          String capacidad = datos[3];
          String matriculados = datos[4];

          List<Horario> horarios = [];
          try {
            Response response = await Dio().get(
              'https://www.uis.edu.co/estudiantes/asignaturas_programadas/horario_asignatura.jsp?codigo=$codigo&grupo=$nombregrupo&nombre=$nombre',
            );
            Document document = parse(response.data);
            List<Element> tablas =
                document.getElementsByClassName('tabla_letra12');
            tablas = tablas.getRange(1, tablas.length).toList();
            for (Element tabla in tablas) {
              List<Element> filas = tabla.getElementsByTagName("tr");
              List<String> datos = _scrapHorarios(filas);

              String dia = datos[0];
              String hora = datos[1];
              String edificio = datos[2];
              String profesor = datos[3];

              Horario horario = Horario(
                  dia: dia, hora: hora, edificio: edificio, profesor: profesor);
              horarios.add(horario);
            }
          } catch (e) {
            print(e);
          }

          List<int> index = Curso.getIndex(
              cursos: cursos, codigo: codigo, nombregrupo: nombregrupo);

          cursos[index[0]].grupos[index[1]].capacidad = int.parse(capacidad);
          cursos[index[0]].grupos[index[1]].matriculados =
              int.parse(matriculados);
          cursos[index[0]].grupos[index[1]].horarios = horarios;
        }
      } catch (e) {
        print(e);
      }
    }
    return cursos;
  }

  List<String> _scrapCursos(List<Element> filas) {
    String nombre = filas[0].getElementsByTagName("td")[0].text.trim();
    String codigo = filas[0]
        .getElementsByTagName("td")[1]
        .text
        .split(':')[1]
        .replaceAll(new RegExp(r"\s+"), "");
    String nombregrupo = filas[1]
        .getElementsByTagName("td")
        .first
        .text
        .split(':')[1]
        .replaceAll(new RegExp(r"\s+"), "");
    String capacidad = filas[2]
        .getElementsByTagName("td")[0]
        .text
        .split(':')[1]
        .replaceAll(new RegExp(r"\s+"), "");
    String matriculados = filas[2]
        .getElementsByTagName("td")[1]
        .text
        .split(':')[1]
        .replaceAll(new RegExp(r"\s+"), "");
    return [nombre, codigo, nombregrupo, capacidad, matriculados];
  }

  List<String> _scrapHorarios(List<Element> filas) {
    String dia = filas[0].getElementsByTagName("td")[1].text.trim();
    String hora = filas[1].getElementsByTagName("td")[1].text.trim();
    String edificio = filas[2]
        .getElementsByTagName("td")[1]
        .text
        .trim()
        .replaceAll(new RegExp(r"\s+"), " ");
    String profesor = filas[3].getElementsByTagName("td")[1].text.trim();
    return [dia, hora, edificio, profesor];
  }
}
