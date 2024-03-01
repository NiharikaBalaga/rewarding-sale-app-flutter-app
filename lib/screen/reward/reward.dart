import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/RewardDetail.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_body.dart';
import '../../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart'; // Import the PostPage

class RewardPage extends StatefulWidget {
  RewardPage({Key? key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  // Temporal posts list
  final List<RewardDetail> rewardDetails = [
    RewardDetail(
        starsAmount: 25,
        starsDescription:
            'Early access to exclusive sales - Gain early access to high-demand sales before they are available to the general public'),
    RewardDetail(
        starsAmount: 50,
        starsDescription:
            'Featured Post - Have one of your sale posts featured at the top of the app for a day, increasing visibility and engagement'),
    RewardDetail(
        starsAmount: 75,
        starsDescription:
            'Discount Coupons - Redeem stars for discount coupons at partner retailers'),
    RewardDetail(
      starsAmount: 100,
      starsDescription:
          'Gift Cards - Earn gift cards for popular stores, allowing you to save on purchases',
    ),
    RewardDetail(
      starsAmount: 150,
      starsDescription:
          'VIP Sale Events - Access to VIP sale events where products are available at a steep discount',
    ),
    RewardDetail(
      starsAmount: 200,
      starsDescription:
          'Personal Shopping Assistant - Unlock the services of a personal shopping assistant for a day, who can help find the best deals or rare items online or in-store',
    ),
    RewardDetail(
      starsAmount: 250,
      starsDescription:
          'Exclusive Merchandise - Redeem stars for exclusive merchandise not available to the general public',
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
          child: bodyRewardPage(rewardDetails, context),
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
