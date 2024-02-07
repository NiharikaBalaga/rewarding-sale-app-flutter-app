import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_locations_header.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_posts_list.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_search_filter.dart';
import '../../../constant.dart';

Column bodyHomePage(
    List<Post> posts, List<Location> locations, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      buildSearchProducts(),
      const SizedBox(height: kSpace),
      sectionHeader('Posts'),
      const SizedBox(height: kSpace),
      Expanded(child: postList(context, posts))
    ],
  );
}
