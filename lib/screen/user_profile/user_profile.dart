import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../constant.dart';
import '../MyPost_UI/my_post_ui.dart';
import '../login/components/_body.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserProfileScreen(),
  ));
}

class UserProfileScreen extends StatelessWidget {
  // final String phoneNumber;
  // UserProfileScreen({required this.phoneNumber});
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

  @override
  void initState() {
    super.initState();
    _image = File('assets/images/default-profile-picture.jpg'); // Initial profile picture
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
          'John Doe', // Replace this with the user's name
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          loginController.phoneNumber.value, // Replace this with the user's phone number
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          'john.doe@example.com', // Replace this with the user's email address
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
              onTap: () {
                // Implement action when Log out is tapped
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
}
