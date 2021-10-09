//! SUBMIT BUTTON
import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

Widget submitButton(var formKey) {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return state.presentstatus is LoginSubmitting
          ? SleekCircularSlider(
              appearance: CircularSliderAppearance(
                spinnerMode: true,
                size: 30,
                customColors: CustomSliderColors(
                  progressBarColors: [
                    Colors.blue,
                    Colors.blue.shade600,
                    Colors.blue.shade200
                  ],
                  trackColor: Colors.white,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  },
                  child: Text("Login")),
            );
    },
  );
}
