import 'package:club_central/application_status/application_data.dart';
import 'package:flutter/material.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({Key? key}) : super(key: key);

  @override
  _ApplicationStatusState createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  List<ApplicationData> all_application = [
    ApplicationData(
        roundNo: 1, status: "Accepted", clubName: "ACM", sigName: "Sanganitra"),
    ApplicationData(
        roundNo: 1, status: "Rejected", clubName: "IEEE", sigName: "CompSoc"),
    ApplicationData(
        roundNo: 1, status: "Pending", clubName: "IET", sigName: "Cipher"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      body: ListView.builder(
          itemCount: all_application.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                  onTap: () {},
                  title: Row(
                    children: <Widget>[
                      Text(
                        all_application[index].clubName,
                      ),
                      all_application[index].status == 'Accepted'
                          ? IconButton(
                              icon: const Icon(Icons.check_circle),
                              color: Colors.green,
                              onPressed: () {},
                            )
                          : all_application[index].status == 'Rejected'
                              ? IconButton(
                                  icon: const Icon(Icons.cancel_sharp),
                                  color: Colors.red,
                                  onPressed: () {},
                                )
                              : IconButton(
                                  icon: const Icon(Icons.cached_rounded),
                                  color: Colors.indigo,
                                  onPressed: () {},
                                )
                    ],
                  )),
            );
          }),
    );
  }
}
