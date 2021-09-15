import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import '../databaseconnection.dart';
 //! Module for DropDown Menu to show all Institutes 

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  late String dropdownValue = "";
  List<String> dropdownItems = [];

 
  @override
  void initState() {

    () async {
      //! Accessing the database and getting the institute names before building of widget starts
      await RepositoryProvider.of<DatabaseAuthRepository>(context).connect();
      setState(() {
        dropdownItems =
            RepositoryProvider.of<DatabaseAuthRepository>(context).institutes;
        dropdownValue = dropdownItems[0];
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return dropdownItems.length == 0
        ? Center(child: CircularProgressIndicator())
        : DropdownButton<String>(
            value: dropdownValue == "" ? dropdownItems[0] : dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.lightBlueAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                RepositoryProvider.of<DatabaseAuthRepository>(context)
                    .instituteName = dropdownValue;
                print(RepositoryProvider.of<DatabaseAuthRepository>(context)
                    .instituteName = dropdownValue);
              });
            },
            items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, child: Text(value)),
              );
            }).toList(),
          );
  }
}
