import 'package:club_central/repositories/session_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mongo_dart/mongo_dart.dart' as dartmongo;

class MyPreferencesScreen extends StatefulWidget {
  List<dynamic> item = [];

  @override
  _MyPreferencesScreenState createState() => _MyPreferencesScreenState();
}

class _MyPreferencesScreenState extends State<MyPreferencesScreen> {
  bool _loading = true;
  @override
  void initState() {
    EasyLoading.showInfo(
        'Long Press on a particular title and move to change your preference');
    var database =
        RepositoryProvider.of<DatabaseAuthRepository>(context).database;
    () async {
      setState(() {
        _loading = true;
      });
      var usercoll = database.collection("user");
      var presentuserrecord = await usercoll.findOne({
        'username': RepositoryProvider.of<DatabaseAuthRepository>(context)
            .loggedinUser
            .username
      });
      print(presentuserrecord!['preferences']);

      setState(() {
        widget.item = presentuserrecord['preferences'];
        _loading = false;
      });
    }();

    super.initState();
  }

  Future<void> reorderData(int oldindex, int newindex) async {
    setState(() {
      _loading = true;
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final items = widget.item.removeAt(oldindex);
      widget.item.insert(newindex, items);
    });
    var database =
        RepositoryProvider.of<DatabaseAuthRepository>(context).database;
    var usercoll = database.collection("user");
    await usercoll.updateOne(
        dartmongo.where.eq(
            'username',
            RepositoryProvider.of<DatabaseAuthRepository>(context)
                .loggedinUser
                .username),
        dartmongo.modify.set('preferences', widget.item));
    print("Done");
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Preferences"),
      ),
      body: _loading == true
          ? Center(child: CircularProgressIndicator())
          : ReorderableListView(
              children: <Widget>[
                for (int index = 0; index < widget.item.length; index++)
                  Card(
                    color: Colors.blue[100],
                    key: ValueKey(widget.item[index]),
                    elevation: 3,
                    child: ListTile(
                      title: Text(widget.item[index]),
                      leading: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
              onReorder: reorderData,
            ),
    );
  }
}
