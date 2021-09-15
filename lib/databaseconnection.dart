import 'package:mongo_dart/mongo_dart.dart';

// * Class to maintain all Mongo Atlas Database options

class DatabaseAuthRepository {
  List<String> institutes = []; //* Variable to store list of institutes
  String instituteName = ""; //* Variable to store name of insitute of the user
  late Db
      database; //* Variable to store the database from MongoCloud instead of accessing it everytime

  //! FUNCTION  TO CONNECT TO THE DATABASE
  Future<void> connect() async {
    database = await Db.create(
        "mongodb+srv://nitk:nitk@cluster0.p2ygg.mongodb.net/test?retryWrites=true&w=majority");
    await database.open();
    final coll = database.collection("institutes");
    final institutemap = await coll.find().toList();
    for (var ins in institutemap) {
      institutes.add(ins['Name']);
    }
  }

  //! FUNCTION TO VALIDATE THE LOGIN CREDENTIALS

  Future<bool> login(String username, String password) async {
    final coll = database.collection("globalschema");
    print(instituteName);
    //* Searching for record in database with the selected institute name and username
    var correctrecord = await coll.findOne({
      'instituteName': instituteName,
      "username": username,
    });
    print(correctrecord);
    if (correctrecord == null) {
      throw Exception(
          "Username doesn't exist in database. Try again!"); //*No such record exists
    } else if (correctrecord['isAdmin'] || correctrecord['isSuperAdmin']) {
      throw Exception(
          "You are Admin/Super Admin of Your Institute.Login Using the Website "); //* Admin or SuperAdmin is trying to login using the mobil eapp
    } else if (correctrecord['password'] != password) {
      throw Exception("Passwords dont match!!");//* When Passwords dont match
    } else if (correctrecord['password'] == password) {
      return true; //* When Passwords Match and Login is Succesful
    }
    throw Exception("Login Failed.Try again later!");//* Throw exceptionmessage to take care of other errors
  }
}
