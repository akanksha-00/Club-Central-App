import 'package:bloc/bloc.dart';
import 'package:club_central/posts/models/post_model.dart';
import 'package:club_central/posts/presentation/bloc/posts_events.dart';
import 'package:club_central/posts/presentation/bloc/posts_states.dart';
import 'package:club_central/posts/repository/posts_repository.dart';

class PostsBloc extends Bloc<PostsEvents, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(InitialState());

  @override
  Stream<PostsState> mapEventToState(PostsEvents event) async* {
    if (event is GetPostsEvent) {
      print("Loading");
      yield LoadingState();
      print("loaded");
      try {
        List<PostModel>? posts =
            await postsRepository.getPosts(event.instituteId);
        if (posts == null) {
          yield EmptyState();
        } else {
          yield LoadedState(posts: posts);
        }
      } on Exception catch (e) {
        print(e.toString());
        yield ErrorState();
      }
    } else if (event is AddComment) {
      print("Adding comment");
    }
  }
}
