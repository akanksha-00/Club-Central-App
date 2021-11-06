import 'package:club_central/login/login_screen.dart';
import 'package:club_central/login/nextpage.dart';
import 'package:club_central/models/user.dart';
import 'package:club_central/myprofile/screens/preferences/my_preferences_screen.dart';
import 'package:club_central/repositories/session_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../restart_controller.dart';
import 'bloc/profile_bloc.dart';
import 'screens/changepassword/changepasswordscreen.dart';

class MyProfilePage extends StatefulWidget {
  static const String routeName = '/my-profile-screen';

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List<List> _options = [
    [
      'My Club Preference',
      'View and Update Exclusive Club Preference Order',
      Icons.list_alt,
      Colors.red,
      EditProfileRequest()
    ],
    [
      'Change Password',
      'Change Your Password',
      Icons.visibility_sharp,
      Colors.green[400],
      ChangePasswordRequest()
    ],
    [
      'Logout',
      'Click here to Logout',
      Icons.exit_to_app,
      Colors.black,
      LogoutRequest(),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final User _loggedinUser =
        RepositoryProvider.of<DatabaseAuthRepository>(context).loggedinUser;
    var _database =
        RepositoryProvider.of<DatabaseAuthRepository>(context).database;
    return BlocProvider(
      create: (context) => ProfileBloc(user: _loggedinUser, db: _database),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff2196f3),
          title: Text(
            'My Profile',
            
          ),
          
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            final buttonclick = state.button;
            if (buttonclick is ChangePasswordButtonClick) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<ProfileBloc>(context),
                      child: ChangePasswordScreen()),
                ),
              );
            } else if (buttonclick is LogoutButtonClick) {
              HotRestartController.performHotRestart(context);
            } else if (buttonclick is EditProfileClick) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<ProfileBloc>(context),
                      child: MyPreferencesScreen()),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(
                            'https://icon-library.com/images/human-icon-png/human-icon-png-11.jpg'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                state.user.institute.name,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 500,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _options.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Container(
                              child: Icon(_options[index][2],
                                  color: _options[index][3])),
                          title: Text(_options[index][0]),
                          subtitle: Text(_options[index][1]),
                          onTap: () {
                            context.read<ProfileBloc>().add(_options[index][4]);
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
