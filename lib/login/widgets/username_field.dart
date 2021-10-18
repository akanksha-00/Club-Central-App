import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//! USERNAME FIELD

Widget usernamefield() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return TextFormField(
        obscureText: false,
        validator: (value) =>
            state.isValidUsername ? null : "Length must be greater than 3",
        onChanged: (value) => context.read<LoginBloc>().add(
              UsernameChanged(username: value),
            ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          labelText: 'Username',
          hintText: 'Enter your Username',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue[600],
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[100] as Color, width: 2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[100] as Color, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    },
  );
}
