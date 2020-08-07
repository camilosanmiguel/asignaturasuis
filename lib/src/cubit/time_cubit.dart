import 'dart:async';

import 'package:cupos_uis/src/utils/preferencias.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCubit extends Cubit<Duration> {
  static final TimeCubit _instance = TimeCubit._internal();

  factory TimeCubit() {
    return _instance;
  }
  TimeCubit._internal() : super(Duration(seconds: -1));

  void init(Duration duracion) {
    emit(duracion);
    _counter();
  }

  void reset({bool save = true}) {
    emit(Duration(seconds: 0));
    Preferencias().tiempo = DateTime.now().toIso8601String();
    _counter();
  }

  void _counter() {
    Timer(
      Duration(milliseconds: 1000),
      () {
        if (!state.isNegative) {
          emit(
              DateTime.now().difference(DateTime.parse(Preferencias().tiempo)));
          _counter();
        }
      },
    );
  }
}
