import 'package:club_central/models/club.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter/services.dart';

import '../models/institute.dart';
import '../models/user.dart';
import 'package:club_central/application_status/application_data.dart';

// * Class to maintain all Mongo Atlas Database options

class DatabaseAuthRepository {
  Map<ObjectId, String> institutes =
      {}; //* Variable to store list of institutes
  Institute presentInstitute = new Institute(
      id: ObjectId(), name: ""); //* Present Institute of the logged in user
  late Db
      database; //* Variable to store the database from MongoCloud instead of accessing it everytime
  List<Map<String, dynamic>> evt =
      []; // Variable to store the events of a given calendar
  List<ApplicationData> student_application = [];
  bool isClubAdmin = false;
  User loggedinUser = User(
      id: ObjectId(),
      username: "",
      isAdmin: false,
      isSuperAdmin: false,
      institute: Institute(id: ObjectId(), name: ""));
  ClubUser clubuser = ClubUser(id: ObjectId(), name: "");

  Map<dynamic, String> clubnamemap = {};
  Map<dynamic, String> signamemap = {};

  //! FUNCTION  TO CONNECT TO THE DATABASE
  Future<void> connect() async {
    print("Callled");
    database = await Db.create(
        "mongodb+srv://nitk:nitk@cluster0.p2ygg.mongodb.net/test?retryWrites=true&w=majority");
    await database.open();
    final coll = database.collection("institutes");
    final institutemap = await coll.find().toList();
    for (var ins in institutemap) {
      institutes[ins['_id']] = ins['name'];
    }
  }

  Future<void> fetchEvents() async {
    final eventCollection = database.collection("event");
    final events = await eventCollection.find().toList();
    for (var e in events) {
      if (presentInstitute.id == e['InstituteID']) {
        Map<String, dynamic> temp = {};
        DateTime date = e['date'];
        temp['year'] = date.year;
        temp['month'] = date.month;
        temp['day'] = date.day;
        temp['hour'] = date.hour;
        temp['minutes'] = date.minute;
        temp['duration'] = e['duration(hrs)'];
        temp['name'] = e['name'];
        evt.add(temp);
      }
    }
  }

  Future<void> fetchApplication() async {
    final applicationCollection = database.collection("applications");
    final all_applications = await applicationCollection.find().toList();
    for (var a in all_applications) {
      if (a['username'] == loggedinUser.username) {
        Map<String, dynamic> status_data = a['status'];
        ApplicationData temp = ApplicationData(
            roundNo: status_data['round_no'],
            status: status_data['status'],
            clubName: clubnamemap[a['club_id']].toString(),
            sigName: signamemap[a['sig_id']].toString());
        student_application.add(temp);
      }
    }
  }

  //! FUNCTION TO VALIDATE THE LOGIN CREDENTIALS
  Future<bool> login(String username, String password) async {
    final coll = database.collection("globalschema");
    //* Searching for record in database with the selected institute name and username
    var correctrecord = await coll.findOne({
      "username": username,
    });

    print(correctrecord);
    isClubAdmin = correctrecord!['isAdmin'];
    if (correctrecord == null) {
      throw Exception(
          "Username doesn't exist in database. Try again!"); //*No such record exists
    } else if (correctrecord['isSuperAdmin'] == true) {
      throw Exception(
          "You are Super Admin of Your Institute.Login Using the Website ");
    } //* SuperAdmin is trying to login using the mobile app
    if (await FlutterBcrypt.verify(
            password: password, hash: correctrecord['password']) ==
        false) {
      throw Exception("Passwords dont match!!"); //* When Passwords dont match
    } else if (await FlutterBcrypt.verify(
            password: password, hash: correctrecord['password']) ==
        true) {
      //! CHANGE LATER
      presentInstitute = Institute(
          id: correctrecord['instituteName'],
          name: institutes[correctrecord['instituteName']] as String);

      print("Ins id ${presentInstitute.id}");

      if (correctrecord['isAdmin'] == false) {
        loggedinUser = User(
            id: correctrecord['_id'],
            username: correctrecord['username'],
            isAdmin: correctrecord['isAdmin'],
            isSuperAdmin: correctrecord['isSuperAdmin'],
            institute: presentInstitute);
        print(loggedinUser.isAdmin);
        final usercoll = database.collection("user");
        var userrecord = await usercoll.findOne({
          "username": loggedinUser.username,
        });
        print(userrecord!['name']);
        loggedinUser.name = userrecord['name'];
        var clubcoll = database.collection("globalschema");
        var institute_clubs = await clubcoll.find(
            {"isAdmin": true, "instituteName": presentInstitute.id}).toList();
        clubcoll = database.collection("club");
        var clubrecord = await clubcoll.find().toList();
        for (var clubuser in institute_clubs) {
          for (var record in clubrecord) {
            if (clubuser['username'] == record['username']) {
              print(clubuser['username']);
              clubnamemap[record['_id']] = record['name'];
            }
          }
        }
        var sigscoll = database.collection("sigs");
        var sigrecord = await sigscoll.find().toList();
        for (var record in sigrecord) {
          signamemap[record['_id']] = record['name'];
        }

        print(clubnamemap);
        print(signamemap);

        return true;
      } else {
        final usercoll = database.collection("club");
        var userrecord = await usercoll.findOne({
          "username": username,
        });
        print(userrecord);
        clubuser.id = userrecord!['_id'];
        clubuser.name = userrecord['name'];
        return true;
      }

      //* When Passwords Match and Login is Succesful
    }
    throw Exception(
        "Login Failed.Try again later!"); //* Throw exceptionmessage to take care of other errors
  }
}
