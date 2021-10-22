import 'package:club_central/myprofile/bloc/profile_bloc.dart';
import 'package:club_central/myprofile/screens/changepassword/passwordfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/changepwd_bloc.dart';

final _formKey = GlobalKey<FormState>();

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Change Password")),
        body: BlocProvider(
          create: (context) => ChangepwdBloc(
              user: BlocProvider.of<ProfileBloc>(context).user,
              database: BlocProvider.of<ProfileBloc>(context).db),
          child: BlocListener<ChangepwdBloc, ChangepwdState>(
            listener: (context, state) {
              final _updatestatus = state.status;
              if (_updatestatus is UpdateFail) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(_updatestatus.message),
                  duration: Duration(milliseconds: 400),
                  backgroundColor: Colors.red,
                ));
              } else if (_updatestatus is UpdateSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Updation Successful"),
                  duration: Duration(milliseconds: 400),
                  backgroundColor: Colors.green,
                ));
                
              }
            },
            child: ChangePasswordForm(context),
          ),
        ));
  }

  Widget ChangePasswordForm(var context) {
    return BlocBuilder<ChangepwdBloc, ChangepwdState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.remove_red_eye),
                        hintText: "Old Password"),
                    validator: (value) => state.isValidOldPassword
                        ? null
                        : "Length must be greater than 6",
                    onChanged: (value) => context
                        .read<ChangepwdBloc>()
                        .add(OldPwdChanged(oldpassword: value))),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.remove_red_eye),
                        hintText: "New Password"),
                    validator: (value) => state.isValidNewPassword
                        ? null
                        : "Length must be greater than 6",
                    onChanged: (value) => context
                        .read<ChangepwdBloc>()
                        .add(NewPwdChanged(newpassword: value))),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Entered");
                      context.read<ChangepwdBloc>().add(UpdateButtonClicked());
                    }
                  },
                  child: Text("Update Password"))
            ],
          ),
        );
      },
    );
  }
}
