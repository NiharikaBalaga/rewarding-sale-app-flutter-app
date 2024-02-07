import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_body.dart';
import '../../constant.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

// Temporal Locations list
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

  // Temporal posts list
  final List<Post> posts = [
    Post(
      name: 'Post 1',
      location: 'Location 1',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 2',
      location: 'Location 2',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 3',
      location: 'Location 3',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 4',
      location: 'Location 4',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 5',
      location: 'Location 5',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 6',
      location: 'Location 6',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 7',
      location: 'Location 7',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            children: [
              const Text(
                'Harry Potter',
                style: TextStyle(color: Colors.white, letterSpacing: 1.8),
              ),
              const Spacer(),
              GestureDetector(
                // Todo: complete onTap
                //onTap: () => Get.to(const LoginScreen()),
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
          child: bodyHomePage(posts, locations, context),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor, // Set the background color
        selectedItemColor: Colors.white, // Set the selected item color
        unselectedItemColor: Colors.grey, // Set the unselected item color
        selectedLabelStyle: const TextStyle(
            color: Colors.white), // Set the selected label color
        unselectedLabelStyle: const TextStyle(
            color: Colors.grey), // Set the unselected label color
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
      ),
    );
  }
}
