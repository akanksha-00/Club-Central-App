import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../databaseconnection.dart';
import 'bloc/login_bloc.dart';
import 'dropdown.dart';
import 'nextpage.dart';
//* LOGIN SCREEN
final _formKey = GlobalKey<FormState>();
class LoginView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<DatabaseAuthRepository>(),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            final formStatus = state.presentstatus;
            if (formStatus is LoginSuccess) {
              //* Pushing the Next page to the screen stack

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NextPage()),
              );
            } else if(formStatus is LoginFailed){
              //* Showing snackbar when  login failed

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(formStatus.exceptionmessage),
                duration: Duration(milliseconds: 400),
              ));
              
            }
          },
          child: _loginForm(),
        ),
      ),
    );
  }
}
//! LOGIN FORM WIDGET
Widget _loginForm() {
  return Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Select your Institute",style: TextStyle(fontSize: 16),),
              Padding(
                padding: const EdgeInsets.only(right:10),
                child: DropDown(),
              ),
            ],
          ),
          _usernamefield(),
          _passwordfield(),
          _submitButton()
        ],
      ),
    ),
  );
}
//! USERNAME FIELD
Widget _usernamefield() {
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
//! PASSWORD FIELD
Widget _passwordfield() {
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
              ));
    },
  );
}
//! SUBMIT BUTTON
Widget _submitButton() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return state.presentstatus is LoginSubmitting
          ? CircularProgressIndicator()
          : Padding(
            padding: const EdgeInsets.only(top:20),
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                child: Text("Login")),
          );
    },
  );
}
