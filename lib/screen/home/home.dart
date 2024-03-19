import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_body.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart'; // Import the PostService
import '../user_profile/user_profile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Location> locations = [
    Location(
        name: "Freshco",
        color: Colors.green,
        imagePath: "assets/images/freshco.png"),
    Location(
        name: "Walmart",
        color: Colors.blue,
        imagePath: "assets/images/walmart.png"),
    Location(
        name: "Winners",
        color: Colors.black,
        imagePath: "assets/images/winners.png"),
  ];

  List<Post> posts = []; // Initialize an empty list for posts

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Fetch posts when the widget initializes
  }

  Future<void> fetchPosts() async {
    try {
      // Fetch posts using the PostService
      List<Post> fetchedPosts = (await PostService.fetchAllPosts()).cast<Post>();

      // Update the state with fetched posts
      setState(() {
        posts = fetchedPosts;
      });
    } catch (error) {
      // Handle errors
      print('Error fetching posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor, // Set your app bar color
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.location,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8), // Space between icon and text
              const Text(
                'Kitchener',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Text(
                  'Harry Potter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to UserProfile screen when profile icon is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfileScreen()),
                  );
                },
                child: const Icon(
                  CupertinoIcons.profile_circled,
                  size: 30,
                  color: Colors.white,
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
          child: bodyHomePage(posts, locations, context), // Pass fetched posts to the bodyHomePage widget
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor, // Set your bottom navigation bar color
        selectedItemColor: Colors.white, // Set the selected item color
        unselectedItemColor: Colors.grey, // Set the unselected item color
        selectedLabelStyle: const TextStyle(
          color: Colors.white, // Set the selected label color
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey, // Set the unselected label color
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
            // Navigate to PostPage when "Post" icon is tapped
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
