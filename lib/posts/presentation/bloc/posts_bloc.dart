import 'package:bloc/bloc.dart';
import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/bloc/posts_events.dart';
import 'package:club_central/posts/presentation/bloc/posts_states.dart';

class PostsBloc extends Bloc<PostsEvents, PostsState> {
  final List<PostModel> posts;

  PostsBloc({required this.posts}) : super(InitialState());

  @override
  Stream<PostsState> mapEventToState(PostsEvents event) async* {
    if (event is GetPostsEvent) {
      yield LoadingState();
      
    }
    throw UnimplementedError();
  }
}
