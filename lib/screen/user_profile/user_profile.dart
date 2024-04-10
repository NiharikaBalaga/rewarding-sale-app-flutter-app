import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_sale_app_flutter_app/screen/user_profile/aboutus_page.dart';
import 'dart:io';

import '../../constant.dart';
import '../../models/CurrentUser.dart';
import '../../services/getcurrentuserservice.dart';
import '../../services/logoutuserservice.dart';
import '../MyPost_UI/my_post_ui.dart';
import '../login/components/_body.dart';
import 'favoritePostsPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserProfileScreen(),
  ));
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
      ),
      body: UserProfile(),
    );
  }
}

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late File _image;
  late String userName = ''; // Variable to store user's full name
  late String email = '';

  @override
  void initState() {
    super.initState();
    _image = File('assets/images/default-profile-picture.jpg'); // Initial profile picture
    fetchCurrentUser(); // Call function to fetch current user
  }

  Future<void> fetchCurrentUser() async {
    try {
      // Call your function to fetch current user here
      CurrentUser currentUser = await CurrentUserService.getCurrentUser();
      // Combine first name and last name to form full name
      setState(() {
        userName = '${_capitalizeFirstLetter(currentUser.firstName)} ${_capitalizeFirstLetter(currentUser.lastName)}';
        email = '${currentUser.email}';
      });
    } catch (error) {
      print('Error fetching current user: $error');
    }
  }

  String _capitalizeFirstLetter(String word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1);
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedFirstName = userName.split(' ')[0];
        String editedLastName = userName.split(' ')[1];
        String editedEmail = email;

        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'First Name'),
                controller: TextEditingController(text: editedFirstName),
                onChanged: (value) {
                  editedFirstName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Last Name'),
                controller: TextEditingController(text: editedLastName),
                onChanged: (value) {
                  editedLastName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: TextEditingController(text: editedEmail),
                onChanged: (value) {
                  editedEmail = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  userName = '$editedFirstName $editedLastName';
                  email = editedEmail;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () async {
                // Call your logout API service here
                bool success = await LogoutApiService().logout();
                if (success) {
                  // After logout, navigate to the home page
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                  );
                } else {
                  // Handle logout failure
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to logout. Please try again.'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToFavoritePostsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritePostsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: _getImage,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/default-profile-picture.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _editProfile, // Changed from _getImage to _editProfile
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Text(
            userName.isNotEmpty ? userName : 'Loading...', // Display user's full name
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            loginController.phoneNumber.value, // Replace this with the user's phone number
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            email.isNotEmpty ? email : 'Loading...',  // Replace this with the user's email address
            style: TextStyle(fontSize: 16),
          ),
          ListTile(
            title: Text('Post Details', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
          ),
          Column(

            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyPostPage()),
                  );
                },
                child: ListTile(
                  title: Text('My Posts'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePostsPage()),
                  );
                },
                child: ListTile(
                  title: Text('Favorite Posts'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  // Implement action when Membership is tapped
                },
                child: ListTile(
                  title: Text('Membership'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
                child: ListTile(
                  title: Text('About us'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100],
                ),
              ),

              Divider(),
              InkWell(
                onTap: () {
                  // Show logout confirmation dialog
                  _showLogoutConfirmationDialog(context);
                },
                child: ListTile(
                  title: Text('Log out'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}


