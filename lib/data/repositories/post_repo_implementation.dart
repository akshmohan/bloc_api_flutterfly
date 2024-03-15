import 'package:bloc_api/data/data_sources/post_remote_data_source.dart';
import 'package:bloc_api/domain/entities/post_entity.dart';
import 'package:bloc_api/domain/repositories/post_repository.dart';

class PostRepoImpl implements PostRepo {
  PostRemoteDataSource postRemoteDataSource = PostRemoteDataSourceImpl();

  @override
  Future<List<PostEntity>> getPostFromDataSource() async {
    final posts = await postRemoteDataSource.getDataFromApi();
    return posts;
  }
}
