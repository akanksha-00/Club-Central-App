import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

import 'nextpage.dart';
import 'widgets/password_field.dart';
import 'widgets/submitbutton.dart';
import 'widgets/username_field.dart';

//* LOGIN SCREEN
final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isConnected = false;
  @override
  void initState() {
    () async {
      //! Accessing the database and getting the institute names before building of widget starts
      await RepositoryProvider.of<DatabaseAuthRepository>(context).connect();
      setState(() {
        _isConnected = true;
      });
    }();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Login",
          textAlign: TextAlign.left,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      body: (_isConnected == false)
          ? Center(child: CircularProgressIndicator())
          : BlocProvider(
              create: (context) => LoginBloc(
                authRepo: context.read<
                    DatabaseAuthRepository>(), //Providing the database Repository to the login screen to get
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
                  } else if (formStatus is LoginFailed) {
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
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Image.asset("assets/icons/logo.png")),
            SizedBox(
              height: 40.0,
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    usernamefield(),
                    passwordfield(),
                    submitButton(_formKey)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}