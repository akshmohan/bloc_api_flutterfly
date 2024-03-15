import 'dart:convert';
import 'package:bloc_api/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getDataFromApi();
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final client = http.Client();

  @override
  Future<List<PostModel>> getDataFromApi() async {
    try {
      final response = await client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          headers: {'content-type': 'application/json'});
      if (response.statusCode == 200) {
        print(response);
        final List<dynamic> responseBody = jsonDecode(response.body);

        final List<PostModel> posts =
            responseBody.map((json) => PostModel.fromJson(json)).toList();

        return posts;
      } else {
        throw Exception("Failed to load posts");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
