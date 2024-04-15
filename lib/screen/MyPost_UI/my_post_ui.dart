import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import '../../constant.dart';
import '../../models/Post.dart'; // Import the updated Post model
import '../../services/getpostservice.dart';
import '../reward/reward.dart';
import 'package:geocoding/geocoding.dart';
import '../user_profile/user_profile.dart';
import '../../services/getcurrentuserservice.dart';
import '../../services/postapiservices.dart';
import '../../models/CurrentUser.dart';

class MyPostPage extends StatefulWidget {
  MyPostPage({Key? key}) : super(key: key);

  @override
  _MyPostPageState createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  List<Post> activePosts = [];
  List<Post> inactivePosts = [];

  String userName = '';
  String location = '';
  String editedProductName = '';
  double editedNewPrice = 0.0;
  int editedNewQuantity = 0;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
    fetchPosts();
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

  Future<void> fetchPosts() async {
    try {
      CurrentUser currentUser = await CurrentUserService.getCurrentUser();
      List<Post> fetchedPosts = await PostService.fetchAllPosts();

      // Get the current date
      DateTime currentDate = DateTime.now();

      // Filter active posts based on the condition
      activePosts = fetchedPosts.where((post) {
        return post.userId == currentUser.id &&
            currentDate.difference(post.createdAt).inDays <= 30;
      }).toList();

      // Filter inactive posts based on the condition
      inactivePosts = fetchedPosts.where((post) {
        return post.userId == currentUser.id &&
            currentDate.difference(post.createdAt).inDays > 30;
      }).toList();

      // Set state to update UI
      setState(() {});
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  Future<void> getUserLocation(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.street}';
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
    //return buildTable(activePosts, context, showEditButton: true, showDeleteButton: true);
    bool hasActivePosts = activePosts.isNotEmpty;

    if (!hasActivePosts) {
      return Center(
        child: Text('No active posts available for display',
          style: TextStyle(
              fontSize: 16, color: Colors.red
          ),
        ),
      );
    }

    return buildTable(
      activePosts,
      context,
      showEditButton: hasActivePosts,
      showDeleteButton: hasActivePosts,
    );
  }
  Widget buildInactivePostsTable(BuildContext context) {
    // Check if there are any inactive posts
    bool hasInactivePosts = inactivePosts.isNotEmpty && inactivePosts[0] != 'No posts more than 1 month old';

    if (!hasInactivePosts) {
      return Center(
        child: Text('No inactive posts available for display',
          style: TextStyle(
              fontSize: 16,
              color: Colors.red
          ),
        ),
      );
    }

    // Display the table with inactive posts
    return buildTable(
      inactivePosts,
      context,
      showDeleteButton: hasInactivePosts,
    );
  }

  Widget buildTable(List<Post> posts, BuildContext context,
      {bool showEditButton = false, bool showDeleteButton = false}) {
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
      width: MediaQuery.of(context).size.width * 1,
      child: DataTable(
        columnSpacing: 120,
        headingRowHeight: 60,
        dataRowHeight: 70,
        headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17),
        headingRowColor:
        MaterialStateColor.resolveWith((states) => kPrimaryColor.withOpacity(0.9)),
        columns: [
          DataColumn(label: Text('Post Name')),
          DataColumn(label: Text('Actions')),
        ],
        rows: posts.map((post) {
          return DataRow(cells: [
            DataCell(Text(
              '${post.productName.split(' ').take(2).join(' ')}',
            )),
            DataCell(
              Row(
                children: [
                  if (showEditButton)
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        _editPost(context, post);
                      },
                    ),
                  if (showDeleteButton)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Show confirmation dialog before deleting the post
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmation"),
                              content: Text(
                                  "Are you sure you want to delete this post \"${post.productName}\"?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    bool deleted = await PostApiService.deletePost(post.id);
                                    if (deleted) {
                                      // Refresh the page after successful deletion
                                      await fetchPosts();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text('Post deleted successfully'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('Failed to delete post'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                    Navigator.of(context).pop();
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

void _editPost(BuildContext context, Post post) {
  String editedProductName = post.productName;
  double editedNewPrice = post.newPrice;
  int editedNewQuantity = post.newQuantity;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edit Post"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: post.productName,
                    maxLines: null, // Allow multiple lines
                    decoration: InputDecoration(labelText: 'Product Name'),
                    onChanged: (value) {
                      editedProductName = value;
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: post.newPrice.toString(),
              decoration: InputDecoration(labelText: 'New Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                editedNewPrice = double.tryParse(value) ?? 0.0;
              },
            ),
            TextFormField(
              initialValue: post.newQuantity.toString(),
              decoration: InputDecoration(labelText: 'New Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                editedNewQuantity = int.tryParse(value) ?? 0;
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              // Perform update operation with edited values
              // For demonstration, just print the edited values
              print('Edited Product Name: $editedProductName');
              print('Edited New Price: $editedNewPrice');
              print('Edited New Quantity: $editedNewQuantity');

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text("Confirm"),
          ),
        ],
      );
    },
  );
}

