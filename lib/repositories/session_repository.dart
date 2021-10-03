import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:flutter/services.dart';

import '../models/institute.dart';
import '../models/user.dart';
// * Class to maintain all Mongo Atlas Database options

class DatabaseAuthRepository {
  Map<ObjectId, String> institutes =
      {}; //* Variable to store list of institutes
  Institute presentInstitute = new Institute(
      id: ObjectId(), name: ""); //* Present Institute of the logged in user
  late Db
      database; //* Variable to store the database from MongoCloud instead of accessing it everytime
  late User loggedinUser;

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

  //! FUNCTION TO VALIDATE THE LOGIN CREDENTIALS
  Future<bool> login(String username, String password) async {
    final coll = database.collection("globalschema");
    //* Searching for record in database with the selected institute name and username
    var correctrecord = await coll.findOne({
      "username": username,
    });
    print(correctrecord);
    if (correctrecord == null) {
      throw Exception(
          "Username doesn't exist in database. Try again!"); //*No such record exists
    } else if (correctrecord['isAdmin'] || correctrecord['isSuperAdmin']) {
      throw Exception(
          "You are Admin/Super Admin of Your Institute.Login Using the Website ");
    } //* Admin or SuperAdmin is trying to login using the mobil eapp
    if (await FlutterBcrypt.verify(
            password: password, hash: correctrecord['password']) ==
        false) {
      throw Exception("Passwords dont match!!"); //* When Passwords dont match
    } else if (await FlutterBcrypt.verify(
            password: password, hash: correctrecord['password']) ==
        true) {
      presentInstitute.id = correctrecord['instituteName'];
      presentInstitute.name = institutes[presentInstitute.id] as String;
      loggedinUser = User(
          id: correctrecord['_id'],
          username: correctrecord['username'],
          isAdmin: correctrecord['isAdmin'],
          isSuperAdmin: correctrecord['isSuperAdmin'],
          institute: presentInstitute);
      final usercoll = database.collection("user");
      var userrecord = await usercoll.findOne({
        "username": loggedinUser.username,
      });
      print(userrecord!['name']);
      loggedinUser.name = userrecord['name'];
      return true;
      //* When Passwords Match and Login is Succesful
    }
    throw Exception(
        "Login Failed.Try again later!"); //* Throw exceptionmessage to take care of other errors
  }
}
