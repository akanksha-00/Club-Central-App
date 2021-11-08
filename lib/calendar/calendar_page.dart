import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../repositories/session_repository.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Appointment> getAppointments(BuildContext context) {
    final events = RepositoryProvider.of<DatabaseAuthRepository>(context).evt;
    List<Appointment> meetings = <Appointment>[];

    for (var e in events) {
      final DateTime startTime =
          DateTime(e['year'], e['month'], e['day'], e['hour'], e['minutes'], 0);
      final DateTime endTime =
          startTime.add(Duration(hours: int.parse(e['duration'])));

      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: e['name'],
          color: Colors.blue));
    }

    return meetings;
  }

  bool _isConnected = false;
  @override
  void initState() {
    () async {
      //! Accessing the database and getting the institute names before building of widget starts
      await RepositoryProvider.of<DatabaseAuthRepository>(context)
          .fetchEvents();
      setState(() {
        _isConnected = true;
      });
    }();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      body: (_isConnected == true)
          ? SfCalendar(
              view: CalendarView.week,
              dataSource: MeetingDataSource(getAppointments(context)),
            )
          : Center(
              child: SpinKitSpinningLines(
                color: Colors.blue,
                lineWidth: 7,
              ),
            ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
