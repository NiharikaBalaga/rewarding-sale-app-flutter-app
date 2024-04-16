import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/CurrentUser.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import 'package:rewarding_sale_app_flutter_app/screen/user_profile/user_profile.dart';
import 'package:rewarding_sale_app_flutter_app/services/getcurrentuserservice.dart';
import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart';
import 'package:rewarding_sale_app_flutter_app/services/searchservice.dart'; // Import the search service

import 'components/_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];
  String userLocation = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      List<Post> fetchedPosts = await PostService.fetchAllPosts();
      setState(() {
        posts = fetchedPosts;
      });
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      CurrentUser currentUser = await CurrentUserService.getCurrentUser();
      String lastName = currentUser.lastName;
      setState(() {
        userName = '$lastName';
      });
      await getUserLocation(
          currentUser.lastLatitude, currentUser.lastLongitude);
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }

  Future<void> getUserLocation(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.street}';
        setState(() {
          userLocation = address;
        });
      } else {
        print('No placemarks found for the provided coordinates.');
      }
    } catch (error) {
      print('Error fetching user location: $error');
    }
  }

  Future<void> _refresh() async {
    await fetchCurrentUser();
    await fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              const Icon(
                CupertinoIcons.location,
                size: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Text(
                userLocation.isNotEmpty ? userLocation : 'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                userName.isNotEmpty
                    ? userName[0].toUpperCase() + userName.substring(1)
                    : 'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(),
                    ),
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                buildSearchProducts(), // Add search bar
                // Expanded(
                //   child: bodyHomePage(posts, context), // Display posts
                // ),
                Expanded(
                  child: posts.isEmpty // Check if there are no search results
                      ? Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                      : bodyHomePage(posts, context), // Display posts
                ),
              ],
            ),
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
      ),
    );
  }

  // Function to build the search bar
  Row buildSearchProducts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search Bar
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 2.0,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Expanded(
                    child: _showTextField((value) {
                      _performSearch(value);
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showTextField(Function(String) onSubmitted) {
    return TextField(
      onSubmitted: (query) {
        // Call _performSearch if query is not empty
        if (query.isNotEmpty) {
          onSubmitted(query);
        } else {
          // Call fetchPosts if query is empty
          fetchPosts();
        }
      },
      decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }


  void _performSearch(String query) async {
    try {
      if (query.isEmpty) {
        // If query is empty, fetch all posts
        await fetchPosts();
      } else {
        // Call the search service to fetch results
        final List<Post> searchResults = await SearchService.search(query);
        // Process the search results here, e.g., update UI with the results
        setState(() {
          posts = searchResults;
        });
        print('Search Results: $searchResults');
      }
    } catch (error) {
      // Handle errors if any
      print('Error during search: $error');
    }
  }
}
