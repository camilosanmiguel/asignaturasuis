import 'package:flutter/material.dart';

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
          onTap: () => query = '',
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
        onTap: () => Navigator.of(context).pop(),
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          //CardGruop(),
          //SizedBox(height: 30),
          //CardGruop(),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
