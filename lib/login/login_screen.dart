import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../databaseconnection.dart';
import 'bloc/login_bloc.dart';
import 'widgets/dropdown.dart';
import 'nextpage.dart';
import 'widgets/password_field.dart';
import 'widgets/submitbutton.dart';
import 'widgets/username_field.dart';
//* LOGIN SCREEN
final _formKey = GlobalKey<FormState>();
class LoginScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<DatabaseAuthRepository>(),//Providing the database Repository to the login screen to get 
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
          child: loginForm(),
        ),
      ),
    );
  }
}
//! LOGIN FORM WIDGET
Widget loginForm() {
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
          usernamefield(),
          passwordfield(),
          submitButton(_formKey)
        ],
      ),
    ),
  );
}


