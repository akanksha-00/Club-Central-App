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
    ApplicationData(
        roundNo: 1, status: "Accepted", clubName: "IE", sigName: "Code"),
    ApplicationData(
        roundNo: 2, status: "Pending", clubName: "ACM", sigName: "Saahitya"),
    ApplicationData(
        roundNo: 2, status: "Accepted", clubName: "IE", sigName: "InkHeart"),
    ApplicationData(
        roundNo: 3, status: "Rejected", clubName: "ISTE", sigName: "Clutch"),
    ApplicationData(
        roundNo: 2, status: "Accepted", clubName: "ISTE", sigName: "Crypt"),
    ApplicationData(
        roundNo: 3, status: "Pending", clubName: "ISTE", sigName: "Gadget"),
    ApplicationData(
        roundNo: 3, status: "Accepted", clubName: "IE", sigName: "Gadget"),
    ApplicationData(
        roundNo: 2, status: "Reject", clubName: "IE", sigName: "Garage"),
    ApplicationData(
        roundNo: 1, status: "Pending", clubName: "ISTE", sigName: "Chronicle"),
    ApplicationData(
        roundNo: 2, status: "Accepted", clubName: "IET", sigName: "Venture"),
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
                                ),
                      Text(
                        all_application[index].clubName,
                      ),
                      Text(
                        " - " + all_application[index].sigName,
                      ),
                      Text(
                        " - Round " +
                            all_application[index].roundNo.toString() +
                            " ",
                      ),
                    ],
                  )),
            );
          }),
    );
  }
}
