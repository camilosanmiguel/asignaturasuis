import 'package:flutter_bloc/flutter_bloc.dart';

class TimeCubit extends Cubit<int> {
  TimeCubit() : super(1);

  void init(int time) => emit(time);

  void plus() => emit(state + 1);

  void reset() => emit(0);
}
