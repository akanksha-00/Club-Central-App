import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../repositories/session_repository.dart';

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
      final DateTime startTime = DateTime(
          int.parse(e['year']),
          int.parse(e['month']),
          int.parse(e['day']),
          int.parse(e['hour']),
          0,
          0);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      body: SfCalendar(
        view: CalendarView.week,
        dataSource: MeetingDataSource(getAppointments(context)),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
