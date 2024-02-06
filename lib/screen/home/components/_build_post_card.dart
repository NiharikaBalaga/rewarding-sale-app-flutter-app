import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';

buildPostCard(Post post) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Card(
      elevation: 4,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: GridTile(
          header: Padding(
            padding: const EdgeInsets.all(12),
            child: imageIcon(post),
          ),
          footer: _buildPriceRating(post),
          child: Container(),
        ),
      ),
    ),
  );
}

Padding _buildPriceRating(Post post) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titlePrice(post),
        const SizedBox(height: 8),
        // showStarRating(3.0, product.color)
      ],
    ),
  );
}

Text description(Post post) {
  return Text(
    post.name,
    maxLines: 2,
  );
}

Row _titlePrice(Post post) {
  return Row(
    children: [
      Text(
        post.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      Text(
        '\$ ${post.sale}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      )
    ],
  );
}

Image imageIcon(Post post) {
  return Image.asset(
    post.imagePath,
    fit: BoxFit.cover,
    height: 100,
    width: 100,
  );
}
