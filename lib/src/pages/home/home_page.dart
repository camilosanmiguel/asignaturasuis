import 'package:cupos_uis/src/cubit/curso_cubit.dart';
import 'package:cupos_uis/src/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/header.dart';
import 'widgets/subheader.dart';
import 'widgets/body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CursoCubit>(context);
    cubit.update();
    SearchCubit().setFalse();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Header(),
            SubHeader(),
            Body(),
          ],
        ),
      ),
    );
  }
}
