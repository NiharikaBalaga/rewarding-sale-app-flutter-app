import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import 'package:rewarding_sale_app_flutter_app/screen/user_profile/user_profile.dart';

import '../home/home.dart';

class FavoritePostsPage extends StatefulWidget {
  FavoritePostsPage({Key? key}) : super(key: key);

  @override
  _FavoritePostsPageState createState() => _FavoritePostsPageState();
}

class Post {
  final String productName; // Change title to productName
  final String postCategory; // Change description to postCategory
  final String productImageObjectUrl; // Change imageUrl to productImageObjectUrl

  Post({
    required this.productName,
    required this.postCategory,
    required this.productImageObjectUrl,
  });
}
class _FavoritePostsPageState extends State<FavoritePostsPage> {
  final List<Post> favoritePosts = [
    Post(
      productName: 'Post 1',
      postCategory: 'Description of Post 1',
      productImageObjectUrl: 'https://via.placeholder.com/150',
    ),
    Post(
      productName: 'Post 2',
      postCategory: 'Description of Post 2',
      productImageObjectUrl: 'https://via.placeholder.com/150',
    ),
    Post(
      productName: 'Post 3',
      postCategory: 'Description of Post 3',
      productImageObjectUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
             const SizedBox(width: 50),
              Text(
                'Favorite Posts', // Customize the title
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        titleSpacing: 24.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemCount: favoritePosts.length,
            itemBuilder: (context, index) {
              final post = favoritePosts[index];
              return Column(
                children: [
                  ListTile(
                    title: Text(post.productName),
                    subtitle: Text(post.postCategory),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(post.productImageObjectUrl),
                    ),
                    trailing: SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the full post page or perform any action
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          child: Text(
                            "View Post",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rewards',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RewardPage()),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostPage()),
            );
          }
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }
}
