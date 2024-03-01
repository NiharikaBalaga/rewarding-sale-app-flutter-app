import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import '../../constant.dart';
import '../Post_UI/PostPage.dart';
import '../home/home.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int upvoteCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(widget.post.name),
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
                  widget.post.imagePath,
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
              widget.post.name,
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto'), // Apply a modern font style
            ),
            SizedBox(height: 20),
            Text(
              'Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.post.location,
              style: TextStyle(fontSize: 16, fontFamily: 'Roboto'), // Apply a modern font style
            ),
            SizedBox(height: 20),
            Text(
              'Price:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '${widget.post.sale}% off',
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
                    _showReportDialog(context);
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
                    setState(() {
                      upvoteCount++; // Increment upvote count
                      print('upvote count: $upvoteCount');
                    });
                    _showFlyingAnimation(context);
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

  void _showReportDialog(BuildContext context) {
    String selectedOption = ''; // Variable to store the selected option

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Select Reason"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("Out of stock"),
                    tileColor: selectedOption == 'Out of stock' ? Colors.grey.withOpacity(0.3) : null,
                    onTap: () {
                      setState(() {
                        selectedOption = 'Out of stock'; // Set selected option
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Misleading"),
                    tileColor: selectedOption == 'Misleading' ? Colors.grey.withOpacity(0.3) : null,
                    onTap: () {
                      setState(() {
                        selectedOption = 'Misleading'; // Set selected option
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Not Found"),
                    tileColor: selectedOption == 'Not Found' ? Colors.grey.withOpacity(0.3) : null,
                    onTap: () {
                      setState(() {
                        selectedOption = 'Not Found'; // Set selected option
                      });
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: selectedOption.isEmpty
                      ? null
                      : () {
                    // Print selected option and handle confirmation
                    print('Selected option: $selectedOption');
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    ); // Redirect to home page
                  },
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showFlyingAnimation(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    OverlayEntry entry = OverlayEntry(
      builder: (context) => Positioned(
        right: position.dx,
        top: position.dy,
        child: TweenAnimationBuilder(
          duration: Duration(milliseconds: 500),
          tween: Tween(begin: -500.0, end: 0.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(-100, -value),
              child: Icon(Icons.thumb_up, color: Colors.blue, size: 42),
            );
          },
        ),
      ),
    );

    Overlay.of(context)?.insert(entry);

    Future.delayed(Duration(milliseconds: 500), () {
      entry.remove();
    });
  }
}
