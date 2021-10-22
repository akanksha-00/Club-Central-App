import 'package:club_central/add_a_post/clubadminscreen.dart';
import 'package:club_central/home_page/presentation/pages/home_page.dart';
import 'package:club_central/login/widgets/login_background.dart';
import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

import 'nextpage.dart';
import 'widgets/password_field.dart';
import 'widgets/submitbutton.dart';
import 'widgets/username_field.dart';
import 'package:concentric_transition/concentric_transition.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

//* LOGIN SCREEN
final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  static final routeName = '/login';
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
      body: (_isConnected == false)
          ? Center(
              child: SpinKitSpinningLines(
                color: Colors.blue,
                lineWidth: 7,
              ),
            )
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
                    print("Here");
                    print(RepositoryProvider.of<DatabaseAuthRepository>(context)
                        .loggedinUser
                        .isAdmin);

                    if (RepositoryProvider.of<DatabaseAuthRepository>(context)
                            .isClubAdmin ==
                        true) {
                      var text_greetings = [
                        Text(
                          "Greetings ${RepositoryProvider.of<DatabaseAuthRepository>(context).clubuser.name}!!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.white70,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Welcome to Club Central!!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.blue[300] as Color,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ]),
                        )
                      ];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConcentricPageView(
                                  colors: <Color>[
                                    Colors.blue,
                                    Colors.white,
                                  ],

                                  onFinish: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClubAdminScreen(),
                                    ),
                                  ),

                                  itemCount: 2, // null = infinity
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (int index, double value) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 170),
                                              text_greetings[index]
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                      );
                    } else if (RepositoryProvider.of<DatabaseAuthRepository>(
                                context)
                            .loggedinUser
                            .isSuperAdmin ==
                        false) {
                      var text_greetings = [
                        Text(
                          "Greetings\n ${RepositoryProvider.of<DatabaseAuthRepository>(context).loggedinUser.username}!!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.white70,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Welcome to Club Central!!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.blue[300] as Color,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ]),
                        )
                      ];
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConcentricPageView(
                                  colors: <Color>[
                                    Colors.blue,
                                    Colors.white,
                                  ],

                                  onFinish: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  ),

                                  itemCount: 2, // null = infinity
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (int index, double value) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 170),
                                              text_greetings[index]
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                      );
                    }
                  } else if (formStatus is LoginFailed) {
                    //* Showing snackbar when  login failed

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(formStatus.exceptionmessage),
                      duration: Duration(milliseconds: 400),
                    ));
                  }
                },
                child: Container(
                  child: LoginBackground(
                    formwidget: loginForm(),
                  ),
                ),
              ),
            ),
    );
  }
}

//! LOGIN FORM WIDGET
Widget loginForm() {
  return Container(
    height: 50,
    child: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Product-Sans'),
                    ),
                    alignment: Alignment.topLeft),
                    SizedBox(height: 20),
                usernamefield(),
                SizedBox(height: 20),
                passwordfield(),
                submitButton(_formKey)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}