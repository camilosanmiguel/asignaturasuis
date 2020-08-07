import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cupos_uis/src/cubit/time_cubit.dart';

class SubHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCubit, Duration>(
      cubit: TimeCubit(),
      builder: (BuildContext context, Duration state) {
        String txt = '';
        if (state.inDays != 0) {
          txt = "${state.inDays} Dias";
        } else if (state.inHours != 0) {
          txt = "${state.inHours} Horas";
        } else if (state.inMinutes != 0) {
          txt = "${state.inMinutes} Minutos";
        } else {
          txt = "${state.inSeconds} Segundos";
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
