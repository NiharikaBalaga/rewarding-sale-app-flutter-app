import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import '../../constant.dart';
import '../../models/Post.dart';
import '../reward/reward.dart';
import 'package:geocoding/geocoding.dart';
import '../user_profile/user_profile.dart';
import '../../services/getcurrentuserservice.dart';
import '../../models/CurrentUser.dart';


class MyPostPage extends StatefulWidget {
  MyPostPage({Key? key}) : super(key: key);

  @override
  _MyPostPageState createState() => _MyPostPageState();
}
class Post {
  final String productName;
  final String quantity;
  final String price;

  Post({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}
class _MyPostPageState extends State<MyPostPage> {
  List<String> activePosts = ['Active Post 1', 'Active Post 2', 'Active Post 3'];
  List<String> inactivePosts = ['Inactive Post 1', 'Inactive Post 2'];

  String userName = '';
  String location = '';

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


  Widget buildActivePostsTable(BuildContext context) {
    return buildTable(activePosts, context, showEditButton: true, showDeleteButton: true);
  }

  Widget buildInactivePostsTable(BuildContext context) {
    return buildTable(inactivePosts, context, showDeleteButton: true);
  }

  Widget buildTable(List<String> posts, BuildContext context, {bool showEditButton = false, bool showDeleteButton = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 1, // Adjust width to 100% of screen width
      child: DataTable(
        columnSpacing: 120,
        headingRowHeight: 50, // Adjust header row height
        dataRowHeight: 70, // Adjust data row height
        headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17), // Color for header text
        headingRowColor: MaterialStateColor.resolveWith((states) => kPrimaryColor.withOpacity(0.9)), // Background color for header row
        columns: [
          DataColumn(label: Text('Post Name')),
          DataColumn(label: Text('Actions')),
        ],
        rows: posts.map((post) {
          return DataRow(cells: [
            DataCell(Text(post)),
            DataCell(
              Row(
                children: [
                  if (showEditButton) // Conditionally render edit button based on showEditButton flag
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green), // Change color of edit icon to green
                      onPressed: () {
          // Implement action for editing post

                      },
                    ),
                  if (showDeleteButton) // Conditionally render delete button based on showDeleteButton flag
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red), // Change color of delete icon to red
                      onPressed: () {
                        // Show confirmation dialog before deleting the post
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmation"),
                              content: Text("Are you sure you want to delete this post \"$post\"?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      posts.remove(post);
                                    });
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  userName.isNotEmpty
                      ? userName[0].toUpperCase() + userName.substring(1)
                      : 'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),

              ),

              GestureDetector(
                onTap: () {
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TabBar(
                labelColor: Colors.black,
                indicatorColor: Color(0xFF1B2A72),
                tabs: [
                  Tab(text: 'Active Posts'),
                  Tab(text: 'Inactive Posts'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Active Posts',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        buildActivePostsTable(context),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Inactive Posts',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        buildInactivePostsTable(context),
                      ],
                    ),
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

