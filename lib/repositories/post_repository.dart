import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posts_app/models/post.dart';

class PostRepository {
    final http.Client client;

  PostRepository({required this.client});
  
  final String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts(int startIndex, int limit) async {
    final response = await http.get(Uri.parse('$_baseUrl?_start=$startIndex&_limit=$limit'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
