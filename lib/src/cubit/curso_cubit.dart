import 'package:bloc/bloc.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';
import 'package:cupos_uis/src/models/curso.dart';

class CursoCubit extends Cubit<List<Curso>> {
  CursoCubit() : super([]);

  void update() {
    //bajarShardPreferences
    //realizarPeticionHTTP

    //peticion fail
    //no guarda envia el mismo
    //tiempo el mismo

    //peticion ok!
    //GuardarShardPreferences
    //emitirListaCursos

    emit([]);
    TimeCubit().reset();
  }

  void buscar(String hola) {
    //bajarShardPreferences
    //realizarPeticionHTTP
    //crearListaCursos-cotejada con la guardada en el shard
    //emitirListaCursos
    print(hola);
  }

  void toggleFav(Curso curso) {
    //bajarShardPreferences
    //Añadir Curso o Eliminar
    //guardarShardPreferences
    //EmitirListaCursos
  }
}
