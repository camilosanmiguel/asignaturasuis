import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<bool> {
  static final SearchCubit _instance = SearchCubit._internal();

  factory SearchCubit() {
    return _instance;
  }
  SearchCubit._internal() : super(false);

  void setTrue() => emit(true);

  void setFalse() => emit(false);
}
