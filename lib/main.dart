import 'package:cupos_uis/src/cubit/curso_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CursoCubit(),
      child: MaterialApp(
          title: 'Cupos Uis',
          debugShowCheckedModeBanner: false,
          home: HomePage()),
    );
  }
}
