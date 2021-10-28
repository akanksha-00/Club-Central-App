import 'package:club_central/application_status/application_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../repositories/session_repository.dart';

class ApplicationStatusPage extends StatefulWidget {
  const ApplicationStatusPage({Key? key}) : super(key: key);

  @override
  _ApplicationStatusPageState createState() => _ApplicationStatusPageState();
}

class _ApplicationStatusPageState extends State<ApplicationStatusPage> {
  List<ApplicationData> all_application = [];
  bool _isConnected = false;
  @override
  void initState() {
    () async {
      //! Accessing the database and getting the institute names before building of widget starts
      await RepositoryProvider.of<DatabaseAuthRepository>(context)
          .fetchApplication();
      all_application = RepositoryProvider.of<DatabaseAuthRepository>(context)
          .student_application;
      setState(() {
        _isConnected = true;
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Status'),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      body: (_isConnected == false)
          ? Center(
              child: SpinKitSpinningLines(
                color: Colors.blue,
                lineWidth: 7,
              ),
            )
          : ListView.builder(
              itemCount: all_application.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                      onTap: () {},
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          all_application[index].status == 2
                              ? IconButton(
                                  icon: const Icon(Icons.check_circle),
                                  color: Colors.green,
                                  onPressed: () {},
                                )
                              : all_application[index].status == 3
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
                          Container(
                            child: MaterialButton(
                              onPressed: () {},
                              color: Colors.red[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "Round " +
                                    all_application[index].roundNo.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              }),
    );
  }
}
