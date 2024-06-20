import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:posts_app/models/post.dart';
import 'package:posts_app/repositories/post_repository.dart';
import '../mock_client.mocks.dart';

void main() {
  group('PostRepository', () {
    late PostRepository postRepository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      postRepository = PostRepository(client: mockClient);
    });

    test('returns a List of Posts if the http call completes successfully', () async {
      final jsonResponse = jsonEncode([
        {
          "userId": 1,
          "id": 1,
          "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        },
        {
          "userId": 1,
          "id": 2,
          "title": "qui est esse",
          "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
        }
      ]);

      when(mockClient.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_start=0&_limit=2')))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      final posts = await postRepository.fetchPosts(0, 2);

      expect(posts, isA<List<Post>>());
      expect(posts.length, 2);
      expect(posts[0].title, 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit');
      expect(posts[1].title, 'qui est esse');
    });

    test('handles a large number of posts correctly', () async {
      final jsonResponse = jsonEncode(List.generate(100, (index) => {
        "userId": 1,
        "id": index,
        "title": "Post $index",
        "body": "Body of Post $index"
      }));

      when(mockClient.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_start=0&_limit=100')))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      final posts = await postRepository.fetchPosts(0, 100);

      expect(posts, isA<List<Post>>());
      expect(posts.length, 100);
    });
  });
}
