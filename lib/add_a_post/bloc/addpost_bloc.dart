import 'package:bloc/bloc.dart';
import 'package:club_central/add_a_post/models/newpost.dart';
import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddPostState> {
  final Db database;
  AddpostBloc(this.database)
      : super(
          AddPostState(
              newpost: NewPost(
                  title: "gg",
                  description: "",
                  date: DateTime.now(),
                  clubid: ObjectId(),
                  instituteId:ObjectId(),
                  imageUrl: ""),
              status: InitialStatus()),
        );
  @override
  Stream<AddPostState> mapEventToState(AddpostEvent event) async* {
    if (event is PostChanged) {
      yield state.copyWith(event.newPost, InitialStatus());
    } else if (event is AddPostButtonClicked) {
      yield state.copyWith(state.newpost, UploadingPost());
      try {
        final usersCollection = database.collection("posts");
        print(state.newpost.description);
        await usersCollection.insert({
          'Title': state.newpost.title,
          'Date': state.newpost.date,
          'Description': state.newpost.description,
          'ClubId': state.newpost.clubid,
          'ImageLink': state.newpost.imageUrl,
          'Comments': [],
          'InstituteId':state.newpost.instituteId,
      

        });
        yield state.copyWith(state.newpost, UploadSuccessful());
      } catch (e) {
        state.copyWith(state.newpost, UploadFailed(exception: "Upload Failed"));
      }
    }
  }
}
