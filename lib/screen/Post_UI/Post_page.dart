import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/components/_postbody.dart';
import '../../constant.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
        actions: [
          // Add Post button to AppBar
          TextButton(
            onPressed: () {
              // Handle the action when the Post button is pressed
              // You can navigate to another page or perform any desired action
              print('Post button pressed');
            },
            child: Text(
              'Post',
              style: TextStyle(color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),

      body: postBody(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        // Set the background color
        selectedItemColor: Colors.white,
        // Set the selected item color
        unselectedItemColor: Colors.grey,
        // Set the unselected item color
        selectedLabelStyle: TextStyle(color: Colors.white),
        // Set the selected label color
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        // Set the unselected label color
        items: [
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
