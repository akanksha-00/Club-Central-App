//! PASSWORD FIELD
import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget passwordfield() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(Icons.security), hintText: 'Enter Password'),
        validator: (value) =>
            state.isValidPassword ? null : "Length must be greater than 6",
        onChanged: (value) => context.read<LoginBloc>().add(
              PasswordChanged(password: value),
            ),
      );
    },
  );
}
