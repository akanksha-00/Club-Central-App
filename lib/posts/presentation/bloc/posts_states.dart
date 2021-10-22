import 'package:club_central/posts/models/post_model.dart';

abstract class PostsState {}

class InitialState extends PostsState {}

class LoadingState extends PostsState {}

class EmptyState extends PostsState {}

class LoadedState extends PostsState {
  final List<PostModel> posts;

  LoadedState({required this.posts});
}

class ErrorState extends PostsState {}
