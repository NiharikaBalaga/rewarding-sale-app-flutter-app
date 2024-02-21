import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import '../../constant.dart';
import '../Post_UI/PostPage.dart';
import '../home/home.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(post.name),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  post.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Product Name:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              post.name,
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto'), // Apply a modern font style
            ),
            SizedBox(height: 20),
            Text(
              'Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              post.location,
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto'), // Apply a modern font style
            ),
            SizedBox(height: 20),
            Text(
              'Price:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${post.sale}% off',
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto'), // Apply a modern font style
            ),
            SizedBox(height: 20),
            Text(
              'Quantity:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '10',
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto'), // Apply a modern font style
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for the Report button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set red color for the Report button
                    textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ,fontSize: 18), // Set text color and style
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder( // Set border radius
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),// Set minimum button size
                  ),
                  child: Text('Report',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for the Upvote button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set green color for the Upvote button
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder( // Set border radius
                      borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                    ),// Set minimum button size
                  ),
                  child: Text('Upvote',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
          ],
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


