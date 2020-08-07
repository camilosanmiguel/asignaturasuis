import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static final Preferencias _instance = Preferencias._ctor();
  factory Preferencias() {
    return _instance;
  }

  Preferencias._ctor();
  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get cursos {
    return _prefs.getString('cursos') ?? '[]';
  }

  set cursos(String cursos) {
    _prefs.setString('cursos', cursos);
  }

  String get tiempo {
    return _prefs.getString('tiempo') ?? '';
  }

  set tiempo(String tiempo) {
    _prefs.setString('tiempo', tiempo);
  }
}
