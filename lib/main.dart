import 'package:asignaturasuis/src/cubit/curso_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

//TODO AGREGAR ICONO Y SPLASH SCREEN
//TODO HACER RESPONSIVO TODO EL DISEÑO

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CursoCubit(),
      child: MaterialApp(
          title: 'Asignaturas Uis',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            accentColor: Colors.grey,
            scaffoldBackgroundColor: Colors.white,
            canvasColor: Colors.transparent,
          ),
          home: HomePage()),
    );
  }
}
