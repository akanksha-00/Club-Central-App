//! SUBMIT BUTTON
import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

Widget submitButton(var formKey) {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return state.presentstatus is LoginSubmitting
          ? SpinKitPulse(
              color: Colors.blue,
              size: 10,
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AnimatedButton(
                  height: 40,
                  width: 100,
                  text: 'Sign In',
                  isReverse: true,
                  selectedTextColor: Colors.black,
                  transitionType: TransitionType.LEFT_TO_RIGHT,
                  backgroundColor: Colors.blue,
                  borderColor: Colors.white,
                  borderRadius: 50,
                  borderWidth: 2,
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  }),
              // child: ElevatedButton(
              //     onPressed: () {
              //       if (formKey.currentState!.validate()) {
              //         context.read<LoginBloc>().add(LoginSubmitted());
              //       }
              //     },
              //     child: Text("Login"),),
            );
    },
  );
}
