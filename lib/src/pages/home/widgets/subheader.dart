import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';

class SubHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCubit, int>(
      cubit: TimeCubit(),
      builder: (BuildContext context, int state) => state.isNegative
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                "Actualizado hace $state segundos",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff9E9E9E),
                ),
              ),
            ),
    );
  }
}
