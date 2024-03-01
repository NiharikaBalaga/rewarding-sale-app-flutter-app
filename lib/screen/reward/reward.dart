import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/models/EarningStar.dart';
import 'package:rewarding_sale_app_flutter_app/models/RewardDetail.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_build_earning_star_card.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_reward_details_body.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import '../../constant.dart';

class RewardPage extends StatefulWidget {
  RewardPage({Key? key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  final List<RewardDetail> rewardDetails = [
    RewardDetail(
        starsAmount: 25,
        starsDescription:
            'Early access to exclusive sales - Gain early entry to top sales before they go public'),
    RewardDetail(
        starsAmount: 50,
        starsDescription:
            'Featured Post - Get your sale post featured for enhanced visibility for a day'),
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
          'Personal Shopping Assistant - Access a personal shopping assistant for top deals and rare finds for a day',
    ),
    RewardDetail(
      starsAmount: 250,
      starsDescription:
          'Exclusive Merchandise - Redeem stars for special merchandise not available to the public',
    ),
  ];

  final List<EarningStar> earningStars = [
    EarningStar(
      description: "Enter to check out one of your posts!",
      imagePath: 'assets/images/computer.png',
    ),
    EarningStar(
      description: "Like and decide to upvote your post!",
      imagePath: 'assets/images/computer.png',
    ),
    EarningStar(
      description: "Share one of your posts!",
      imagePath: 'assets/images/computer.png',
    ),
    EarningStar(
      description: "Reach 10 posts in the app",
      imagePath: 'assets/images/computer.png',
    ),
    EarningStar(
      description: "Refer friends to the app",
      imagePath: 'assets/images/computer.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(
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
              const SizedBox(width: 8),
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color of tabs
                boxShadow: [
                  BoxShadow(
                    color: Colors
                        .grey.shade300, // Light gray color for the bottom line
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: const TabBar(
                labelColor: Colors.black, // Color of the text
                indicatorColor:
                    Color(0xFF1B2A72), // Color of the active tab line
                tabs: [
                  Tab(text: 'My Rewards'),
                  Tab(text: 'Earning Stars'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: bodyRewardPage(rewardDetails, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: buildEarningStarsPage(earningStars, context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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
