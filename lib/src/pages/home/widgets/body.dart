import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asignaturasuis/src/cubit/curso_cubit.dart';
import 'package:asignaturasuis/src/models/curso.dart';

import 'package:asignaturasuis/src/pages/widgets/card_group.dart';
import 'package:asignaturasuis/src/pages/widgets/texto.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CursoCubit, List<Curso>>(
      builder: (_, cursos) => cursos.isEmpty
          ? Texto(
              texto: "No Tienes Grupos \nGuardados Dale Click En\nBuscar Grupo",
            )
          : Expanded(
              child: LiquidPullToRefresh(
                backgroundColor: Colors.grey,
                color: Colors.white,
                height: 50,
                showChildOpacityTransition: false,
                onRefresh: () {
                  var cubit = BlocProvider.of<CursoCubit>(context);
                  return cubit.update();
                },
                child: ListView.builder(
                  itemCount: cursos.length,
                  itemBuilder: (_, i) => Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: SizedBox(
                        width: 320,
                        child: CardGroup(
                          curso: cursos[i],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
