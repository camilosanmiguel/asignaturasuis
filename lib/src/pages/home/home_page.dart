import 'package:flutter/material.dart';

import 'widgets/header.dart';
import 'widgets/body.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Header(),
            Body(),
          ],
        ),
      ),
    );
  }
}
