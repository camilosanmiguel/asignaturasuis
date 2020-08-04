import 'package:flutter/material.dart';
import 'package:cupos_uis/src/pages/widgets/texto_home_widget.dart';
import 'package:cupos_uis/src/pages/widgets/buscar_widget.dart';
import 'package:cupos_uis/src/pages/widgets/card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cupos_uis/src/cubit/curso_cubit.dart';
import 'package:cupos_uis/src/models/curso.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          appBar(),
          // SizedBox(
          //   height: 10,
          //   width: double.infinity,
          // ),
          BlocBuilder<CursoCubit, List<Curso>>(
            cubit: CursoCubit(),
            builder: (_, cursos) => cursos.isEmpty
                ? TextoHome()
                : Expanded(
                    child: ListView.builder(
                      itemCount: cursos.length,
                      itemBuilder: (_, i) => Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            width: 320,
                            child: CardGruop(
                              curso: cursos[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      )),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.transparent,
            ),
          ),
          Buscar(),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: Color(0xff9E9E9E),
            ),
          ),
        ],
      ),
    );
  }
}
