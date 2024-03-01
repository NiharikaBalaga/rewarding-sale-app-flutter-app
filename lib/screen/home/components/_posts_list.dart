import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_build_post_card.dart';
import 'package:rewarding_sale_app_flutter_app/screen/postdetails/post_details.dart';

import '../../../models/Post.dart';


GridView postList(BuildContext context, List<Post> products) {
  return GridView.count(
    crossAxisCount: 1,
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
        child: buildPostCard(post),
      );
    }),
  );
}

