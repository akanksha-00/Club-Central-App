import 'package:flutter/material.dart';
import 'application_data.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({Key? key}) : super(key: key);

  @override
  _ApplicationStatusState createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  List<ApplicationData> all_application = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
    );
  }
}
