import 'package:bloc/bloc.dart';
import 'package:club_central/models/user.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'changepwd_event.dart';
part 'changepwd_state.dart';

class ChangepwdBloc extends Bloc<ChangepwdEvent, ChangepwdState> {
  final User user;
  final Db database;
  ChangepwdBloc({required this.user, required this.database})
      : super(ChangepwdState(
            newpassword: "", oldpassword: ".", status: InitialStatus()));
  @override
  Stream<ChangepwdState> mapEventToState(ChangepwdEvent event) async* {
    if (event is OldPwdChanged) {
      yield state.copyWith(oldpassword: event.oldpassword);
    } else if (event is NewPwdChanged) {
      yield state.copyWith(newpassword: event.newpassword);
    } else if (event is UpdateButtonClicked) {
      print("Came here");
      yield state.copyWith(status: Updating());
      try {
        final coll = database.collection("globalschema");
        var correctrecord = await coll.findOne({"username": user.username});
        print(correctrecord);
        if (await FlutterBcrypt.verify(
                password: state.oldpassword,
                hash: correctrecord!['password']) ==
            true) {
          print("Correct");
          var salt10 = await FlutterBcrypt.saltWithRounds(rounds: 10);
          var pwh10 = await FlutterBcrypt.hashPw(
              password: state.newpassword, salt: salt10);
          coll.updateOne(where.eq('username', user.username),
              modify.set('password', pwh10));
          yield state.copyWith(status: UpdateSuccess());
        } else {
          yield state.copyWith(status: UpdateFail("Check Old Password again."));
        }
      } catch (e) {
        state.copyWith(status: UpdateFail("Update Failed!!Try Again Later!"));
      }
    }
  }
}
