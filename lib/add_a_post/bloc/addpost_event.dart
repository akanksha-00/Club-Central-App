part of 'addpost_bloc.dart';

@immutable
abstract class AddpostEvent {}

class PostChanged extends AddpostEvent {
  NewPost newPost;
  PostChanged({required this.newPost});
}

class AddPostButtonClicked extends AddpostEvent {}
