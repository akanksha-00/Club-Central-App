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
      try {
        await postsRepository.getPosts();
        print("loaded");
        if (postsRepository.postsList.isEmpty) {
          yield EmptyState();
        } else {
          yield LoadedState(posts: postsRepository.postsList);
        }
      } catch (e) {
        print(e.toString());
        yield ErrorState();
      }
    } else if (event is AddComment) {
      print("Adding comment");
      yield LoadingState();
      try {
        await postsRepository.addComment(
            event.postId, event.commentText, event.userName);
        print("loaded");
        print('got posts');
        yield LoadedState(posts: postsRepository.postsList);
      } catch (e) {
        print(e.toString());
        yield ErrorState();
      }
    } else if (event is DeleteComment) {
      print('deleting comment');
      yield LoadingState();
      print('loading');
      try {
        await postsRepository.deleteComment(event.postId, event.index);
        print('loaded');
        yield LoadedState(posts: postsRepository.postsList);
      } catch (e) {
        print(e.toString());
        yield ErrorState();
      }
    }
  }
}
