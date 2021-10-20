import 'package:flutter/material.dart';
import '../databaseconnection.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CalendarLoad extends StatefulWidget {
  const CalendarLoad({Key? key}) : super(key: key);

  @override
  _CalendarLoadState createState() => _CalendarLoadState();
}

class _CalendarLoadState extends State<CalendarLoad> {
  void dbFetch() async {
    await FetchCalendarEvents.connect();
    Navigator.pushReplacementNamed(context, '/calendar');
  }

  @override
  void initState() {
    super.initState();
    dbFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SpinKitChasingDots(
            color: Colors.black,
            size: 50,
          ),
        ));
  }
}
