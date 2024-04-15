import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class PostCard extends StatefulWidget {
  final Post post;

  PostCard({required this.post});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _likeCount = 10;
  int _viewCount = 20;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _postImage(widget.post),
                  ),
                  _buildPostTexts(widget.post),
                  SizedBox(height: 8),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconButton(
                        icon: _isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                        color: _isLiked ? Colors.red : kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            _isLiked = !_isLiked;
                            if (_isLiked) {
                              _likeCount++;
                            } else {
                              _likeCount--;
                            }
                          });
                        },
                        count: _likeCount,
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.comment,
                        color: kPrimaryColor,
                        onPressed: () {
                          // Add comment functionality here
                        },
                        count: 5,
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.eye,
                        color: kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            _viewCount++;
                          });
                        },
                        count: _viewCount,
                      ),

                      // _buildIconButton(
                      //   icon: FontAwesomeIcons.share,
                      //   color: kPrimaryColor,
                      //   onPressed: () {
                      //     // Add share functionality here
                      //   },
                      //   count: 15,
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required Color color, required Function()? onPressed, required int count}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: color,
            size: 20,
          ),
          onPressed: onPressed,
        ),
        Text(
          count.toString(),
          style: TextStyle(color: kPrimaryColor),
        ),
      ],
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
          post.productImageObjectUrl,
          fit: BoxFit.fitWidth,
          height: 200,
          width: double.infinity,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  post.productName.split(' ').take(2).join(' '),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: kPrimaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${((post.oldPrice - post.newPrice) / post.oldPrice * 100).toStringAsFixed(0)}% Off',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                post.storeName.split(' ').take(2).join(' '),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 140),
              Text(
                post.postCategory.split(' ').take(2).join(' '),
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rewarding_sale_app_flutter_app/constant.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class PostCard extends StatefulWidget {
//   final Post post;
//
//   PostCard({required this.post});
//
//   @override
//   _PostCardState createState() => _PostCardState();
// }
//
// class _PostCardState extends State<PostCard> {
//   int _likeCount = 10;
//   bool _isLiked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2),
//       child: Card(
//         elevation: 3,
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black12,
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.grey[100],
//           ),
//           child: Stack(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: _postImage(widget.post),
//                   ),
//                   _buildPostTexts(widget.post),
//                   SizedBox(height: 8),
//                 ],
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildIconButton(
//                         icon: _isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
//                         color: _isLiked ? Colors.red : kPrimaryColor,
//                         onPressed: () {
//                           setState(() {
//                             _isLiked = !_isLiked;
//                             if (_isLiked) {
//                               _likeCount++;
//                             } else {
//                               _likeCount--;
//                             }
//                           });
//                         },
//                         count: _likeCount,
//                       ),
//                       _buildIconButton(
//                         icon: FontAwesomeIcons.comment,
//                         color: kPrimaryColor,
//                         onPressed: () {
//                           // Add comment functionality here
//                         },
//                         count: 5, // Replace with actual comment count
//                       ),
//                       _buildIconButton(
//                         icon: FontAwesomeIcons.eye,
//                         color: kPrimaryColor,
//                         onPressed: () {
//                           // Add functionality related to viewing the post
//                         },
//                         count: widget.post, // Use post._v for view count
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconButton({required IconData icon, required Color color, required Function()? onPressed, required int count}) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: Icon(
//             icon,
//             color: color,
//             size: 20,
//           ),
//           onPressed: onPressed,
//         ),
//         Text(
//           count.toString(),
//           style: TextStyle(color: kPrimaryColor),
//         ),
//       ],
//     );
//   }
//
//   Widget _postImage(Post post) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black12,
//             width: 2.0,
//           ),
//         ),
//         child: Image.network(
//           post.productImageObjectUrl,
//           fit: BoxFit.fitWidth,
//           height: 200,
//           width: double.infinity,
//         ),
//       ),
//     );
//   }
//
//   Padding _buildPostTexts(Post post) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(
//                   post.productName.split(' ').take(2).join(' '),
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: kPrimaryColor,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 '${((post.oldPrice - post.newPrice) / post.oldPrice * 100).toStringAsFixed(0)}% Off',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Text(
//                 post.storeName.split(' ').take(2).join(' '),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.normal,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(width: 140),
//               Text(
//                 post.postCategory.split(' ').take(2).join(' '),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.normal,
//                   fontSize: 10,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
