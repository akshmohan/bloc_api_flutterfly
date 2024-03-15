import 'package:bloc/bloc.dart';
import 'package:bloc_api/domain/entities/post_entity.dart';
import 'package:bloc_api/domain/use_cases/post_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostRequestedEvent>((event, emit) async {
      print("bloc initialized");

      try {
        final posts = await PostUseCases().getPostFromDataSource();

        emit(PostStateLoaded(posts: posts));
      } catch (e) {
        emit(PostStateError(message: e.toString()));
      }
    });
  }
}
