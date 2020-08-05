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

  get cursos {
    return _prefs.getString('cursos') ?? '[]';
  }

  set cursos(String cursos) {
    _prefs.setString('cursos', cursos);
  }

  get tiempo {
    return _prefs.getInt('tiempo') ?? -1;
  }

  set tiempo(int tiempo) {
    _prefs.setInt('tiempo', tiempo);
  }
}
