import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';

class SubHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCubit, int>(
      cubit: TimeCubit(),
      builder: (BuildContext context, int state) {
        String txt = '';
        if (state > 86400) {
          txt = "${state ~/ 86400} Dias";
        } else if (state > 3600) {
          txt = "${state ~/ 3600} Horas";
        } else if (state > 60) {
          txt = "${state ~/ 60} Minutos";
        } else {
          txt = "$state Segundos";
        }
        return state.isNegative
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "Actualizado hace $txt",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff9E9E9E),
                  ),
                ),
              );
      },
    );
  }
}
