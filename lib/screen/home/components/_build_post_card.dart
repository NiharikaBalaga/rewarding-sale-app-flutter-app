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
            padding: const EdgeInsets.all(0),
            child: _postImage(post),
          ),
          footer: _buildPostTexts(post),
          child: Container(),
        ),
      ),
    ),
  );
}

Widget _postImage(Post post) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(
        15.0), // Ajusta el radio del borde según tus preferencias
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent, // Borde transparente
          width: 2.0, // Ancho del borde
        ),
      ),
      child: Image.asset(
        post.imagePath,
        fit: BoxFit.fill,
        height: 280,
        width: 100,
      ),
    ),
  );
}

Padding _buildPostTexts(Post post) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postTexts(post),
        const SizedBox(height: 8),
        // showStarRating(3.0, product.color)
      ],
    ),
  );
}

Widget _postTexts(Post post) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            post.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '${post.sale}%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      const SizedBox(
          height:
              8), // Ajusta el espacio vertical entre las filas según tus preferencias
      Row(
        children: [
          Text(
            post.location,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );
}
