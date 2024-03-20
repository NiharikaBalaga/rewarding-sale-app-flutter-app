import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/screen/postdetails/post_details.dart';
import '../../../models/Post.dart';
import '_build_post_card.dart';


GridView postList(BuildContext context, List<Post> products) {
  return GridView.count(
    crossAxisCount: 1, // Adjust the cross-axis count as per your UI design
    children: List.generate(products.length, (index) {
      final post = products[index];
      return GestureDetector(
        onTap: () {
          // Navigate to PostDetailPage when a post is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostDetailPage(post: post)),
          );
        },
        child: SizedBox(
          height: 200, // Set the desired height here
          child: PostCard(post: post), // Use the PostCard widget here
        ),
      );
    }),
  );
}
