import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_body.dart';
import '../../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart'; // Import the PostPage

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      name: 'Mcdonalds Big Mac',
      location: 'Ottawa Street, Kitchener',
      sale: 25,
      imagePath: 'assets/images/food.png',
    ),
    Post(
      name: 'Lenovo Laptop',
      location: 'Best Buy, waterloo',
      sale: 20,
      imagePath: 'assets/images/computer.png',
    ),
    Post(
      name: 'Whole Chicken',
      location: 'Walmart, Bridgeport',
      sale: 20,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Bear fluffy toy',
      location: 'Boardwalk Walmart',
      sale: 15,
      imagePath: 'assets/images/bear.png',
    ),
    Post(
      name: 'Super Home Appliances set',
      location: 'Costco, Kitchener',
      sale: 10,
      imagePath: 'assets/images/homeappliances.png',
    ),
    Post(
      name: 'Womens Bag',
      location: 'Old Navy, Waterloo',
      sale: 5,
      imagePath: 'assets/images/bag.png',
    ),
    Post(
      name: 'Mens - Shoe',
      location: 'Sport Check, Kitchener',
      sale: 5,
      imagePath: 'assets/images/shoe.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
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
              const SizedBox(width: 8), // Espacio entre el icono y el texto
              const Text(
                'Kitchener',
                style: TextStyle(
                    color: Colors.white, fontSize: 16, letterSpacing: 1.2),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Text(
                  'Harry Potter',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, letterSpacing: 1.2),
                ),
              ),
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
        onTap: (index) {
          if (index == 1) {
            // Navigate to PostPage when "Post" icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostPage()),
            );
          }
          if (index == 0){
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
