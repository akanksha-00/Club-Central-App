import 'package:club_central/add_a_post/bloc/addpost_bloc.dart';
import 'package:club_central/application_status/application_status.dart';
import 'package:club_central/calendar/calendar_page.dart';

import 'package:club_central/home_page/presentation/pages/home_page.dart';
import 'package:club_central/myprofile/myprofile_screen.dart';
import 'package:club_central/recruitment_application/presentation/bloc/recruitments_bloc.dart';
import 'package:club_central/recruitment_application/presentation/pages/recruitment_portal.dart';
import 'package:club_central/recruitment_application/repository/recruitment_repository.dart';
import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NextPage extends StatefulWidget {
  static final routeName = "/club-admin-screen";

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      BlocProvider(
        create: (context) => RecruitmentsBloc(
            recruitmentRepository: RecruitmentRepository(
          database:
              RepositoryProvider.of<DatabaseAuthRepository>(context).database,
          username: RepositoryProvider.of<DatabaseAuthRepository>(context)
              .loggedinUser
              .username,
        )),
        child: RecruitmentsPortalPage(
            institute: RepositoryProvider.of<DatabaseAuthRepository>(context)
                .presentInstitute),
      ),
      CalendarPage(),
      ApplicationStatusPage(),
      MyProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("My Posts"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.group),
        title: ("Recruitments"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_today_outlined),
        title: ("Calendar"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.checklist_rtl),
        title: ("Applications"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddpostBloc(
          RepositoryProvider.of<DatabaseAuthRepository>(context).database),
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: false, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}

class CalenderPage {}

class ActiveRecruitment {}
