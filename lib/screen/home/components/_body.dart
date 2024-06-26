import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_locations_header.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_posts_list.dart';

Column bodyHomePage(
    List<Post> posts, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 10),
      sectionHeader('Posts'),
      const SizedBox(height: 15),
      Expanded(child: postList(context, posts)),
      const SizedBox(height: 15),
    ],
  );

}
