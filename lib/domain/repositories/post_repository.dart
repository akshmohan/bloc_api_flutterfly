import 'package:bloc_api/domain/entities/post_entity.dart';

abstract class PostRepo {
  Future<List<PostEntity>> getPostFromDataSource();
}
