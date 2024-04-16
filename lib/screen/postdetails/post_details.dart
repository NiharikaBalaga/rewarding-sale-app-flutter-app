import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import '../../constant.dart';
import '../../models/CurrentUser.dart';
import '../../services/commentservice.dart';
import '../../services/getcurrentuserservice.dart';
import '../../services/reportservice.dart';
import '../../services/voteservice.dart';
import '../Post_UI/PostPage.dart';
import '../home/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  int upvoteCount = 0;
  int _currentImageIndex = 0;
  late List<String> comments; // List to store comments
  bool _isEditing = false;
  late int _editIndex;
  late TextEditingController _editController;
  late TextEditingController _commentController;
  bool _isButtonConfirmed = false;
  String _confirmationMessage = '';
  bool _showAllComments = false;
  late CurrentUser currentUser;
  List<String> commentIds = []; // List to hold comment IDs
  late List<Map<String, dynamic>> commentsList;

  @override
  void initState() {
    super.initState();
    _fetchComments();
    _fetchCurrentUser();
    comments = List<String>.from(widget.post.comments ?? []);
    _editController = TextEditingController();
    _commentController = TextEditingController();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      currentUser = await CurrentUserService.getCurrentUser();
      setState(() {});
    } catch (error) {
      print('Failed to fetch current user: $error');
    }
  }

  void _fetchComments() {
    final String postId = widget.post.id;
    CommentService.getComments(postId).then((List<dynamic> commentsData) {
      setState(() {
        // Extract comment text and IDs from each comment object
        this.comments = commentsData
            .map((comment) => comment['comment'] as String)
            .toList();
        this.commentIds =
            commentsData.map((comment) => comment['_id'] as String).toList();
        commentsList = commentsData.map((item) {
          return {
            'id': item['_id'], // Assuming '_id' is a key in your response
            'comment': item[
                'comment'], // Assuming 'comment' is a value in your response
          };
        }).toList();
      });
    }).catchError((error) {
      print('Failed to fetch comments: $error');
      // Handle error here
    });
  }

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
            icon: Icon(Icons.share),
            onPressed: () {
              final RenderBox box = context.findRenderObject() as RenderBox;
              Share.share(
                'Check out this post: ${widget.post.productName}\n\n${widget.post.productImageObjectUrl}',
                subject: 'Post Details',
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
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
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Image.network(
                    widget.post.priceTagImageObjectUrl,
                    fit: BoxFit.cover,
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
                      color: _currentImageIndex == index
                          ? kPrimaryColor
                          : Colors.grey,
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
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.productName,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Category:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.postCategory,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Store Name:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.storeName,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Location:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      widget.post.storeAddress,
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'New Price:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '${widget.post.newPrice}',
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Old Price:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          '${widget.post.oldPrice}',
                          style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'New Quantity:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      '${widget.post.newQuantity}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Old Quantity:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                    subtitle: Text(
                      '${widget.post.oldQuantity}',
                      style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                    ),
                  ),
                  // _buildConfirmButton(),
                  Center(
                    // Wrap the button with Center widget
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildConfirmButton(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Comments',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  SizedBox(height: 10),
                  _buildAddCommentField(), // Render the add comment UI
                  SizedBox(height: 10),
                  _buildComments(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showReportDialog(context);
                        },
                        child: Column(
                          children: [
                            Icon(Icons.flag,
                                color: Colors.red, size: 36), // Flag icon
                            Text('Report',
                                style: TextStyle(
                                    color: Colors.red)), // Text below the icon
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await VoteService.voteForPost(widget.post.id);
                            setState(() {
                              upvoteCount++; // Increment upvote count
                              print('upvote count: $upvoteCount');
                            });
                            _showFlyingAnimation(context);
                          } catch (error) {
                            print('Failed to vote for post: $error');
                            // Handle error here
                          }
                        },
                        child: Column(
                          children: [
                            Icon(Icons.thumb_up,
                                color: Colors.green, size: 36), // Thumb up icon
                            Text('Upvote',
                                style: TextStyle(
                                    color:
                                        Colors.green)), // Text below the icon
                          ],
                        ),
                      ),
                    ],
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
          color: Colors.white,
        ), // Set the selected label color
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
        ), // Set the unselected label color
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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RewardPage()),
            );
          }
        },
      ),
    );
  }

  // Widget to add a new comment
  Widget _buildAddCommentField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: InputBorder.none, // Remove the default border
                contentPadding:
                    EdgeInsets.all(12), // Adjust the content padding
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            if (_commentController.text.isNotEmpty) {
              try {
                await CommentService.createComment(
                    widget.post.id, _commentController.text);
                // setState(() {
                //   comments.add(_commentController.text);
                _commentController.clear();
                // });
                _fetchComments();
              } catch (error) {
                print('Failed to add comment: $error');
                // Handle error here
              }
            }
          },
          icon: Icon(Icons.send, color: kPrimaryColor),
        ),
      ],
    );
  }

  Widget _buildComments() {
    // Check if there are no comments yet
    if (comments.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Other Comments',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'No comments yet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      );
    }

    // Reverse the order of comments to display the latest ones first
    List<Map<String, dynamic>> reversedComments =
        commentsList.reversed.toList();
    int remainingComments = reversedComments.length - 1;
    List<Map<String, dynamic>> displayedComments = reversedComments.sublist(
        0, _showAllComments ? reversedComments.length : 1);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Other Comments',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: displayedComments.asMap().entries.map((entry) {
                int commentIndex = entry.key;
                String commentId = entry.value.values.toList()[0];
                String commentText = entry.value.values.toList()[1];
                bool isCurrentUserComment =
                    currentUser != null && currentUser.id == widget.post.userId;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _isEditing && commentIndex == _editIndex
                                ? TextField(
                                    controller: _editController,
                                    onSubmitted: (editedComment) {
                                      setState(() {
                                        //comments[commentIndex] = editedComment;
                                        _isEditing = false;
                                      });
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(commentText),
                                  ),
                          ),
                          if (isCurrentUserComment)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (!_isEditing) {
                                        _editIndex = commentIndex;
                                        _editController.text = commentText;
                                        _isEditing = true;
                                      } else {
                                        comments[_editIndex] =
                                            _editController.text;

                                        // Call editComment service
                                        CommentService.editComment(
                                                commentId, _editController.text)
                                            .then((response) {
                                          // Handle the response if needed
                                          print('Comment edited successfully');
                                          _fetchComments();
                                        }).catchError((error) {
                                          // Handle errors
                                          print(
                                              'Error editing comment: $error');

                                          _fetchComments();
                                        });

                                        _isEditing = false;
                                      }
                                    });
                                  },
                                  icon: _isEditing
                                      ? Icon(Icons.check, color: Colors.green)
                                      : Icon(Icons.edit, color: kPrimaryColor),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      // Optimistically remove the comment from the UI
                                      comments.removeAt(commentIndex);
                                      commentIds.removeAt(commentIndex);

                                      // Call the deleteComment service with the comment ID
                                      CommentService.deleteComment(commentId)
                                          .then((response) {
                                        // Handle the response if needed
                                        print('Comment deleted successfully');
                                        _fetchComments();
                                      }).catchError((error) {
                                        // Revert the changes if an error occurs
                                        // setState(() {
                                        //   comments.insert(commentIndex, commentText); // Reinsert the comment
                                        //   commentIds.insert(commentIndex, commentId); // Reinsert the comment ID
                                        // });
                                        print('Error deleting comment: $error');
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Divider(), // Add a divider between comments
                    ],
                  ),
                );
                // }
              }).toList(),
            ),
          ),
          if (remainingComments > 0)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showAllComments = !_showAllComments;
                });
              },
              child: Text(
                _showAllComments
                    ? 'Hide Comments'
                    : 'View $remainingComments more comments',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
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
              title: Text("Select Reason",
                  style: TextStyle(fontSize: 20, color: kPrimaryColor)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text("OUT_OF_STOCK"),
                    tileColor: selectedOption == 'OUT_OF_STOCK'
                        ? Colors.grey.withOpacity(0.3)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedOption = 'OUT_OF_STOCK'; // Set selected option
                      });
                    },
                  ),
                  ListTile(
                    title: Text("MISLEADING"),
                    tileColor: selectedOption == 'MISLEADING'
                        ? Colors.grey.withOpacity(0.3)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedOption = 'MISLEADING'; // Set selected option
                      });
                    },
                  ),
                  ListTile(
                    title: Text("NOT_FOUND"),
                    tileColor: selectedOption == 'NOT_FOUND'
                        ? Colors.grey.withOpacity(0.3)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedOption = 'NOT_FOUND'; // Set selected option
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
                          // Pass the selected report type to the report service
                          ReportService.fetchReport(
                              widget.post.id, selectedOption);
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

  // Function to handle the button press
  void _handleConfirmButtonPress() {
    setState(() {
      // Toggle confirmation status
      _isButtonConfirmed = !_isButtonConfirmed;
      if (_isButtonConfirmed) {
        // Store confirmation message if button is confirmed
        _confirmationMessage = 'CONFIRMATION';
        print(_confirmationMessage);
        ReportService.fetchReport(widget.post.id, _confirmationMessage);
      }
    });
  }

  Widget _buildConfirmButton() {
    return TextButton(
      onPressed: _handleConfirmButtonPress,
      style: TextButton.styleFrom(
        backgroundColor: _isButtonConfirmed ? Colors.green : Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 56, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        'Confirm',
        style:
            TextStyle(fontSize: 16, fontFamily: 'Roboto', color: Colors.white),
      ),
    );
  }
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

  Future.delayed(Duration(milliseconds: 300), () {
    entry.remove();
  });
}
