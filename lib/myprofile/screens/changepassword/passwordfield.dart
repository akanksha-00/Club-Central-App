//! PASSWORD FIELD
import 'package:club_central/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget passwordfield(String hinttext) {
  return TextFormField(
    obscureText: true,
    decoration: InputDecoration(icon: Icon(Icons.security), hintText: hinttext),
    validator: (value) => "Length must be greater than 6",
  );
}
