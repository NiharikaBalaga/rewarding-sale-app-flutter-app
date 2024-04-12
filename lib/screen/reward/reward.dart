import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rewarding_sale_app_flutter_app/models/EarningStar.dart';
import 'package:rewarding_sale_app_flutter_app/models/RewardDetail.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_build_earning_star_card.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_reward_details_body.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import '../../constant.dart';
import '../../models/CurrentUser.dart';
import '../../services/getcurrentuserservice.dart';
import '../user_profile/user_profile.dart';

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
            'Early access to exclusive sales - Gain entry to top sales before they go public'),
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
          'Gift Cards - Earn one for popular stores, allowing you to save on purchases',
    ),
    RewardDetail(
      starsAmount: 150,
      starsDescription:
          'VIP Sale Events - Access to events where products are available at a steep discount',
    ),
    RewardDetail(
      starsAmount: 200,
      starsDescription:
          'Personal Shopping Assistant - Gets an assistant for top deals and rare finds for a day',
    ),
    RewardDetail(
      starsAmount: 250,
      starsDescription:
          'Exclusive Merchandise - Special merchandise not available to the public',
    ),
  ];

  final List<EarningStar> earningStars = [
    EarningStar(
      description: "A user visits one of your posts!",
      imagePath: 'assets/images/user_visits_a_post.png',
    ),
    EarningStar(
      description: "A user likes and decides to upvote your post!",
      imagePath: 'assets/images/user_likes_a_post.png',
    ),
    EarningStar(
      description: "A user shares one of your posts!",
      imagePath: 'assets/images/user_shares_a_post.png',
    ),
    EarningStar(
      description: "You've reached 10 posts in the app!",
      imagePath: 'assets/images/user_reached_ten_posts.png',
    ),
    EarningStar(
      description: "You refer friends to the app",
      imagePath: 'assets/images/user_refers_friends.png',
    ),
  ];

  late String userName = '';
  late String location = '';

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
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
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.locality}';
        setState(() {
          location = address;
        });
      } else {
        print('No placemarks found for the provided coordinates.');
      }
    } catch (error) {
      print('Error fetching user location: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
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
              Text(
                location.isNotEmpty ? location : 'Loading...',
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, letterSpacing: 1.2),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  userName.isNotEmpty
                      ? userName[0].toUpperCase() + userName.substring(1)
                      : 'Loading...',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 16, letterSpacing: 1.2),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to UserProfile screen when profile icon is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()),
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white, // Background color of tabs
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.blueGrey, // Light gray color for the bottom line
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
        currentIndex: 2,
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
