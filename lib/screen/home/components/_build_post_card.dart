import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';

Widget buildPostCard(Post post) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),
        child: GridTile(
          header: Padding(
            padding: const EdgeInsets.all(8),
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
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 2.0,
        ),
      ),
      child: Image.network(
        post.productImageObjectUrl, // Changed to use the image URL from the fetched post
        fit: BoxFit.fill,
        height: 230,
        width: 100,
      ),
    ),
  );
}

Padding _buildPostTexts(Post post) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postTexts(post),
        const SizedBox(height: 15),
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
            post.productName.split(' ').take(2).join(' '),
            //post.productName, // Changed to use the product name from the fetched post
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),

          ),
          const Spacer(),
          Text(

            '${post.newPrice}', // Changed to use the new price from the fetched post
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),

      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            post.storeName, // Changed to use the store address from the fetched post
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            post.postCategory, // Changed to use the store address from the fetched post
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ],
  );
}


// import 'package:flutter/material.dart';
// import 'package:rewarding_sale_app_flutter_app/constant.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
//
// Widget buildPostCard(Post post) {
//   return Padding(
//     padding: const EdgeInsets.all(2),
//     child: Card(
//       elevation: 3,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black12,
//             width: 2.0,
//           ),
//           borderRadius: BorderRadius.circular(5),
//           color: Colors.grey[100],
//         ),
//         child: GridTile(
//           header: Padding(
//             padding: const EdgeInsets.all(8),
//             child: _postImage(post),
//           ),
//           footer: _buildPostTexts(post),
//           child: Container(),
//         ),
//       ),
//     ),
//   );
// }
//
// Widget _postImage(Post post) {
//   return Container(
//     width: double.infinity, // Make the container take the full width of the screen
//     height: double.infinity, // Make the container take the full height of the screen
//     child: Image.network(
//       post.productImageObjectUrl,
//       fit: BoxFit.cover, // Cover the entire container with the image
//     ),
//   );
// }
//
// Padding _buildPostTexts(Post post) {
//   return Padding(
//     padding: const EdgeInsets.all(10),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _postTexts(post),
//         const SizedBox(height: 15),
//       ],
//     ),
//   );
// }
//
// Widget _postTexts(Post post) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         children: [
//           Text(
//             post.productName,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           const Spacer(),
//           Text(
//             '${post.newPrice}%',
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               color: kPrimaryColor,
//             ),
//           ),
//         ],
//       ),
//       const SizedBox(height: 8),
//       Row(
//         children: [
//           Text(
//             post.storeAddress,
//             style: const TextStyle(
//               fontWeight: FontWeight.normal,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

