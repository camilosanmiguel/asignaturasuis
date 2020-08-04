import 'package:cupos_uis/src/cubit/curso_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/header.dart';
import 'widgets/body.dart';
import 'widgets/subheader.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CursoCubit(),
      child: Scaffold(
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
      ),
    );
  }
}
