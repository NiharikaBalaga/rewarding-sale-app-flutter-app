import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import '../../constant.dart';
import '../Post_UI/PostPage.dart';
import '../home/home.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int upvoteCount = 0;
  int _currentImageIndex = 0;
  bool _isNewPriceConfirmed = false;
  bool _isOldPriceConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          widget.post.productName.split(' ').take(2).join(' '),
          style: TextStyle(
            fontSize: 18, // Set the desired font size for the product name
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share), // Add the share icon
            onPressed: () {
              // Implement the share functionality here
            },
          ),
        ],
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                ),
                items: [
                  Image.network(
                    widget.post.productImageObjectUrl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  Image.network(
                    widget.post.priceTagImageObjectUrl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                  // Add more images if needed
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2, // Change this number to the total number of images
                      (index) => Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == index ? kPrimaryColor : Colors.grey,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      'Product Name:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.productName,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Category:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.postCategory,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Store Name:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.storeName,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Location:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.storeAddress,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'New Price:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '${widget.post.newPrice}',
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                        ),
                        SizedBox(width: 170),
                        Text(
                          'Confirm',
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto', color: _isNewPriceConfirmed ? Colors.green : Colors.blueGrey),
                        ),
                        IconButton(
                          icon: Icon(
                            _isNewPriceConfirmed ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: _isNewPriceConfirmed ? Colors.green : Colors.blueGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isNewPriceConfirmed = !_isNewPriceConfirmed;
                            });
                            print('New Price Confirmed: $_isNewPriceConfirmed');
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Old Price:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '${widget.post.oldPrice}',
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                        ),
                        SizedBox(width: 170),
                        Text(
                          'Confirm',
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto', color: _isOldPriceConfirmed ? Colors.green : Colors.blueGrey),
                        ),
                        IconButton(
                          icon: Icon(
                            _isOldPriceConfirmed ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: _isOldPriceConfirmed ? Colors.green : Colors.blueGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isOldPriceConfirmed = !_isOldPriceConfirmed;
                            });
                            print('Old Price Confirmed: $_isOldPriceConfirmed');
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'New Quantity:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      '${widget.post.newQuantity}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Old Quantity:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      '${widget.post.oldQuantity}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showReportDialog(context);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.flag, color: Colors.red, size: 36), // Flag icon
                        Text('Report', style: TextStyle(color: Colors.red)), // Text below the icon
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        upvoteCount++; // Increment upvote count
                        print('upvote count: $upvoteCount');
                      });
                      _showFlyingAnimation(context);
                    },
                    child: Column(
                      children: [
                        Icon(Icons.thumb_up, color: Colors.green, size: 36), // Thumb up icon
                        Text('Upvote($upvoteCount)', style: TextStyle(color: Colors.green)), // Text below the icon
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
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
