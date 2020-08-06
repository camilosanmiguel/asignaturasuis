import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCubit extends Cubit<int> {
  static final TimeCubit _instance = TimeCubit._internal();

  factory TimeCubit() {
    return _instance;
  }
  TimeCubit._internal() : super(-1);

  void init(int time) => emit(time);

  void reset() => emit(0);

  // Future<dynamic> _counter() => Future.delayed(
  //       Duration(seconds: 1),
  //       () {
  //         emit(state + 1);
  //         _counter();
  //       },
  //     );

}
