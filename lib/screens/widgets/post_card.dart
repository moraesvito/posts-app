import 'package:flutter/material.dart';
import 'package:posts_app/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12.0),
                _getTag(),
                const SizedBox(height: 8.0),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  post.body,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8.0),
                _getReadMoreButton(),
                const SizedBox(height: 5.0),
              ],
            ),
          ),
          _getImage(context)
        ],
      ),
    );
  }

  Widget _getTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 73, 30, 173),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Community',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _getReadMoreButton() {
    return TextButton(
      onPressed: () {},
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Read more ', textAlign: TextAlign.left, style: TextStyle(color: Color.fromARGB(255, 21, 75, 200))),
          Icon(Icons.arrow_forward, color: Color.fromARGB(255, 21, 75, 200)),
        ],
      ),
    );
  }

  Widget _getImage(BuildContext context) {
    return SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('lib/assets/images/post-image.png', fit: BoxFit.cover)));
  }
}
