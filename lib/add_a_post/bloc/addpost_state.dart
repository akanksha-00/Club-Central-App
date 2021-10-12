part of 'addpost_bloc.dart';

class AddPostState {
  final NewPost newpost;
  final PostUploadStatus status;
  AddPostState({required this.newpost, required this.status});
  bool get isValidTitle => newpost.title.length > 0;
  bool get isValidDescription => newpost.description.length > 0;
  
  AddPostState copyWith(NewPost? newpostupdated, PostUploadStatus? statusupdated) {
    return AddPostState(
      newpost: newpostupdated as NewPost,
      status: statusupdated as PostUploadStatus,
    );
  }
}

@immutable
abstract class PostUploadStatus {
  const PostUploadStatus();
}

class InitialStatus extends PostUploadStatus {
  const InitialStatus();
}

class UploadingPost extends PostUploadStatus {}

class UploadSuccessful extends PostUploadStatus {}

class UploadFailed extends PostUploadStatus {
  final String exception;
  UploadFailed({required this.exception});
}
