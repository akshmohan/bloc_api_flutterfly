import 'package:bloc_api/data/repositories/post_repo_implementation.dart';
import 'package:bloc_api/domain/entities/post_entity.dart';
import 'package:bloc_api/domain/repositories/post_repository.dart';

class PostUseCases {
  PostRepo postRepo = PostRepoImpl();

  Future<List<PostEntity>> getPostFromDataSource() async {
    final posts = await postRepo.getPostFromDataSource();
    return posts;
  }
}
