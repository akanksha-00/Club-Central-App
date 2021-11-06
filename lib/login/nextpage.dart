import 'package:club_central/add_a_post/addpost_screen.dart';
import 'package:club_central/add_a_post/bloc/addpost_bloc.dart';
import 'package:club_central/dummmy/active_recr.dart';
import 'package:club_central/dummmy/application_status.dart';
import 'package:club_central/dummmy/calender.dart';
import 'package:club_central/home_page/presentation/pages/home_page.dart';
import 'package:club_central/login/login_screen.dart';
import 'package:club_central/login/nextpage.dart';
import 'package:club_central/my_posts/mypost_screen.dart';
import 'package:club_central/myprofile/myprofile_screen.dart';
import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NextPage extends StatelessWidget {
  static final routeName = "/club-admin-screen";
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  // TODO: Add posts screen
  List<Widget> _buildScreens() {
    return [HomePage(), CalenderPage1(), ActiveRecruitmentPage(), ApplicationStatusPage(),  MyProfilePage(),];
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

class CalenderPage {
}

class ActiveRecruitment {
}
