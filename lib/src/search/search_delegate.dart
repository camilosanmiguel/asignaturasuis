import 'package:asignaturasuis/src/cubit/time_cubit.dart';
import 'package:asignaturasuis/src/pages/widgets/texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asignaturasuis/src/cubit/curso_cubit.dart';
import 'package:asignaturasuis/src/cubit/search_cubit.dart';
import 'package:asignaturasuis/src/pages/home/widgets/body.dart';
import 'package:asignaturasuis/src/pages/home/widgets/subheader.dart';

class GrupoSearch extends SearchDelegate {
  GrupoSearch({@required String hintText})
      : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          child: Icon(
            Icons.clear,
          ),
          onTap: () {
            query = '';
            showSuggestions(context);
          },
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          var cubit = BlocProvider.of<CursoCubit>(context);
          SearchCubit().setFalse();
          cubit.update();
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var cubit = BlocProvider.of<CursoCubit>(context);
    cubit.buscar(query);
    SearchCubit().setTrue();
    return BlocBuilder(
      cubit: cubit,
      builder: (context, state) {
        if (state.isEmpty) {
          if (TimeCubit().state.isNegative) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Texto(
              texto: "No Se Han Encontrado Grupos",
            );
          }
        } else {
          return Padding(
            padding: EdgeInsets.only(top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SubHeader(),
                Body(),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //CREAR LISTA DE CURSOS SUGERIDOS
    final lista = ["24948", "23427", "23423", "22979"];
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.assignment),
        title: Text(lista[index]),
        onTap: () {
          query = lista[index];
          showResults(context);
        },
      ),
      itemCount: lista.length,
    );
  }
}
