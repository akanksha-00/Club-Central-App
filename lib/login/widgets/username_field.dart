import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//! USERNAME FIELD

Widget usernamefield() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
            icon: Icon(Icons.person), hintText: 'Enter Username'),
        validator: (value) =>
            state.isValidUsername ? null : "Length must be greater than 3",
        onChanged: (value) => context.read<LoginBloc>().add(
              UsernameChanged(username: value),
            ),
      );
    },
  );
}
