import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_sale_app_flutter_app/services/api_services/auth.dart';
import 'dart:io';

import '../../constant.dart';
import '../../models/CurrentUser.dart';
import '../../services/getcurrentuserservice.dart';
import '../MyPost_UI/my_post_ui.dart';
import '../login/components/_body.dart';

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
        userName = '${currentUser.firstName} ${currentUser.lastName}';
        email = '${currentUser.email}';
      });
    } catch (error) {
      print('Error fetching current user: $error');
    }
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    onPressed: _getImage,
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
        SizedBox(height: 20),
        ListTile(
          title: Text('Post Details', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        ),
        Column(

          children: [
            SizedBox(height: 10),
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
                // Implement action when Favorite Products is tapped
              },
              child: ListTile(
                title: Text('Favorite Products'),
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
                // Implement action when About us is tapped
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
              onTap:  () async {
                try {
                  final AuthService authService = AuthService();
                  await authService.logoutUser();
                  Navigator.of(context).pushReplacementNamed('/login');
                } catch(error) {
                  if (kDebugMode) {
                    print('Logout -error---$error');
                  }
                  Navigator.of(context).pushReplacementNamed('/login');
                }
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
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging out..."),
            ],
          ),
        );
      },
    );
  }
}

