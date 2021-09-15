//! SUBMIT BUTTON
import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget submitButton(var formKey) {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return state.presentstatus is LoginSubmitting
          ? CircularProgressIndicator()
          : Padding(
            padding: const EdgeInsets.only(top:20),
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
