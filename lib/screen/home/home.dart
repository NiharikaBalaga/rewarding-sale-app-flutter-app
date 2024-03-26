// import 'package:flutter/material.dart';
// import 'package:rewarding_sale_app_flutter_app/constant.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/home/components/_body.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
// import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart'; // Import the PostService
// import '../user_profile/user_profile.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final List<Location> locations = [
//     Location(
//         name: "Freshco",
//         color: Colors.green,
//         imagePath: "assets/images/freshco.png"),
//     Location(
//         name: "Walmart",
//         color: Colors.blue,
//         imagePath: "assets/images/walmart.png"),
//     Location(
//         name: "Winners",
//         color: Colors.black,
//         imagePath: "assets/images/winners.png"),
//   ];
//
//   List<Post> posts = []; // Initialize an empty list for posts
//
//   @override
//   void initState() {
//     super.initState();
//     fetchPosts(); // Fetch posts when the widget initializes
//   }
//
//   Future<void> fetchPosts() async {
//     try {
//       // Fetch posts using the PostService
//       List<Post> fetchedPosts = (await PostService.fetchAllPosts()).cast<Post>();
//
//       // Update the state with fetched posts
//       setState(() {
//         posts = fetchedPosts;
//       });
//     } catch (error) {
//       // Handle errors
//       print('Error fetching posts: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor, // Set your app bar color
//         iconTheme: IconThemeData(
//           color: Colors.white, // Set the color of the back arrow to white
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(top: 12.0),
//           child: Row(
//             children: [
//               const Icon(
//                 CupertinoIcons.location,
//                 size: 20,
//                 color: Colors.white,
//               ),
//               const SizedBox(width: 8), // Space between icon and text
//               const Text(
//                 'Kitchener',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const Spacer(),
//               const Padding(
//                 padding: EdgeInsets.only(right: 5.0),
//                 child: Text(
//                   'Rajan',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Navigate to UserProfile screen when profile icon is tapped
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => UserProfileScreen()),
//                   );
//                 },
//                 child: const Icon(
//                   CupertinoIcons.profile_circled,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: false,
//         titleSpacing: 24.0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: bodyHomePage(posts, locations, context), // Pass fetched posts to the bodyHomePage widget
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: kPrimaryColor, // Set your bottom navigation bar color
//         selectedItemColor: Colors.white, // Set the selected item color
//         unselectedItemColor: Colors.grey, // Set the unselected item color
//         selectedLabelStyle: const TextStyle(
//           color: Colors.white, // Set the selected label color
//         ),
//         unselectedLabelStyle: const TextStyle(
//           color: Colors.grey, // Set the unselected label color
//         ),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star),
//             label: 'Rewards',
//           ),
//         ],
//         onTap: (index) {
//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => RewardPage()),
//             );
//           }
//           if (index == 1) {
//             // Navigate to PostPage when "Post" icon is tapped
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PostPage()),
//             );
//           }
//           if (index == 0) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:rewarding_sale_app_flutter_app/constant.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
// import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart'; // Import the PostService
// import 'package:geocoding/geocoding.dart'; // Import geocoding library
//
// import '../../models/CurrentUser.dart';
// import '../../services/getcurrentuserservice.dart';
// import '../user_profile/user_profile.dart';
// import 'components/_body.dart'; // Import the CurrentUserService
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   List<Post> posts = []; // Initialize an empty list for posts
//   String userLocation = ''; // Initialize user location variable
//   String userName = ''; // Initialize user name variable
//
//   @override
//   void initState() {
//     super.initState();
//
//    fetchCurrentUser(); // Fetch current user information when the widget initializes
//     fetchPosts();  // Fetch posts when the widget initializes
//   }
//
//   Future<void> fetchPosts() async {
//     try {
//       // Fetch posts using the PostService
//       List<Post> fetchedPosts = (await PostService.fetchAllPosts()).cast<Post>();
//
//       // Update the state with fetched posts
//       setState(() {
//         posts = fetchedPosts;
//       });
//     } catch (error) {
//       // Handle errors
//       print('Error fetching posts: $error');
//     }
//   }
//
//   Future<void> fetchCurrentUser() async {
//     try {
//       // Fetch current user information using the CurrentUserService
//       CurrentUser currentUser = await CurrentUserService.getCurrentUser();
//
//       // Extract user's first name and last name
//       String firstName = currentUser.firstName;
//       String lastName = currentUser.lastName;
//
//       // Set user name
//       setState(() {
//         userName = '$lastName';
//       });
//
//       // Fetch user location using user's latitude and longitude
//       await getUserLocation(currentUser.lastLatitude, currentUser.lastLongitude);
//     } catch (error) {
//       // Handle errors
//       print('Error fetching current user: $error');
//     }
//   }
//
//   Future<void> getUserLocation(double latitude, double longitude) async {
//     try {
//       // Fetch user location using user's latitude and longitude
//       List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//
//       // Check if placemarks is not empty and extract the location address
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String address = '${place.locality}'; // Example: Kitchener, Ontario
//
//         // Update the state with user's location
//         setState(() {
//           userLocation = address;
//         });
//       } else {
//         print('No placemarks found for the provided coordinates.');
//       }
//     } catch (error) {
//       // Handle errors
//       print('Error fetching user location: $error');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor, // Set your app bar color
//         iconTheme: IconThemeData(
//           color: Colors.white, // Set the color of the back arrow to white
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(top: 12.0),
//           child: Row(
//             children: [
//               const Icon(
//                 CupertinoIcons.location,
//                 size: 20,
//                 color: Colors.white,
//               ),
//               const SizedBox(width: 8), // Space between icon and text
//               Text(
//                 userLocation.isNotEmpty ? userLocation : 'Loading...', // Display user location dynamically
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const Spacer(),
//               // const Padding(
//               //   padding: EdgeInsets.only(right: 5.0),
//                 Text(
//                   userName.isNotEmpty ? userName : 'Loading...', // Display user name dynamically
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     letterSpacing: 1.2,
//                   ),
//                 // ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Navigate to UserProfile screen when profile icon is tapped
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => UserProfileScreen()),
//                   );
//                 },
//                 child: const Icon(
//                   CupertinoIcons.profile_circled,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         centerTitle: false,
//         titleSpacing: 24.0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//          // child: bodyHomePage(posts, locations,context),
//           child: Container(), // Replace Container() with your implementation of the bodyHomePage widget
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: kPrimaryColor, // Set your bottom navigation bar color
//         selectedItemColor: Colors.white, // Set the selected item color
//         unselectedItemColor: Colors.grey, // Set the unselected item color
//         selectedLabelStyle: const TextStyle(
//           color: Colors.white, // Set the selected label color
//         ),
//         unselectedLabelStyle: const TextStyle(
//           color: Colors.grey, // Set the unselected label color
//         ),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star),
//             label: 'Rewards',
//           ),
//         ],
//         onTap: (index) {
//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => RewardPage()),
//             );
//           }
//           if (index == 1) {
//             // Navigate to PostPage when "Post" icon is tapped
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PostPage()),
//             );
//           }
//           if (index == 0) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:rewarding_sale_app_flutter_app/constant.dart';
// import 'package:rewarding_sale_app_flutter_app/models/CurrentUser.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
// import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/user_profile/user_profile.dart';
// import 'package:rewarding_sale_app_flutter_app/services/getcurrentuserservice.dart';
// import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<Post> posts = [];
//   String userLocation = '';
//   String userName = '';
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCurrentUser();
//     fetchPosts();
//   }
//
//   Future<void> fetchPosts() async {
//     try {
//       List<Post> fetchedPosts = await PostService.fetchAllPosts();
//       setState(() {
//         posts = fetchedPosts;
//       });
//     } catch (error) {
//       print('Error fetching posts: $error');
//     }
//   }
//
//   Future<void> fetchCurrentUser() async {
//     try {
//       CurrentUser currentUser = await CurrentUserService.getCurrentUser();
//       String firstName = currentUser.firstName;
//       String lastName = currentUser.lastName;
//       setState(() {
//         userName = '$lastName';
//
//       });
//       await getUserLocation(currentUser.lastLatitude, currentUser.lastLongitude);
//     } catch (error) {
//       print('Error fetching current user: $error');
//     }
//   }
//
//   Future<void> getUserLocation(double latitude, double longitude) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String address = '${place.locality}';
//         setState(() {
//           userLocation = address;
//         });
//       } else {
//         print('No placemarks found for the provided coordinates.');
//       }
//     } catch (error) {
//       print('Error fetching user location: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: Row(
//             children: [
//               const Icon(
//                 CupertinoIcons.location,
//                 size: 20,
//                 color: Colors.white,
//               ),
//               const SizedBox(width: 5),
//               Text(
//                 userLocation.isNotEmpty ? userLocation : 'Loading...',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 userName.isNotEmpty ? userName[0].toUpperCase() + userName.substring(1)  : 'Loading...',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//               const SizedBox(width: 5),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => UserProfileScreen()),
//                   );
//                 },
//
//                 child: const Icon(
//                   CupertinoIcons.profile_circled,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//         centerTitle: false,
//         titleSpacing: 24.0,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Container(), // Replace Container() with your implementation of the bodyHomePage widget
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: kPrimaryColor,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         selectedLabelStyle: const TextStyle(
//           color: Colors.white,
//         ),
//         unselectedLabelStyle: const TextStyle(
//           color: Colors.grey,
//         ),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star),
//             label: 'Rewards',
//           ),
//         ],
//         onTap: (index) {
//           if (index == 2) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => RewardPage()),
//             );
//           }
//           if (index == 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => PostPage()),
//             );
//           }
//           if (index == 0) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomePage()),
//             );
//           }
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/CurrentUser.dart';
import 'package:rewarding_sale_app_flutter_app/models/Location.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/PostPage.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import 'package:rewarding_sale_app_flutter_app/screen/user_profile/user_profile.dart';
import 'package:rewarding_sale_app_flutter_app/services/getcurrentuserservice.dart';
import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart';

import 'components/_body.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];
  String userLocation = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();

  }

  Future<void> fetchPosts() async {
    try {
      List<Post> fetchedPosts = await PostService.fetchAllPosts();
      print('Fetched Posts: $fetchedPosts'); // Debug print
      setState(() {
        posts = fetchedPosts;
      });
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      CurrentUser currentUser = await CurrentUserService.getCurrentUser();
      String firstName = currentUser.firstName;
      String lastName = currentUser.lastName;
      setState(() {
        userName = '$lastName';
      });
      await getUserLocation(currentUser.lastLatitude, currentUser.lastLongitude);

    } catch (error) {
      print('Error fetching current user: $error');
    }
  }

  Future<void> getUserLocation(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '${place.locality}';
        setState(() {
          userLocation = address;

        });
        fetchPosts();
      } else {
        print('No placemarks found for the provided coordinates.');
      }
    } catch (error) {
      print('Error fetching user location: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Posts:');
    posts.forEach((post) {
      print('ID: ${post.id}, Title: ${post.productName}'); // Add more fields as needed
    });// Debug print
    return Scaffold(
        appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
        color: Colors.white,
    ),
    title: Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Row(
    children: [
    const Icon(
    CupertinoIcons.location,
    size: 20,
    color: Colors.white,
    ),
    const SizedBox(width: 5),
    Text(
    userLocation.isNotEmpty ? userLocation : 'Loading...',
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    letterSpacing: 1.2,
    ),
    ),
    const Spacer(),
    Text(
    userName.isNotEmpty ? userName[0].toUpperCase() + userName.substring(1)  : 'Loading...',
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    letterSpacing: 1.2,
    ),
    ),
    const SizedBox(width: 5),
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
    body: SafeArea(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
      child: bodyHomePage(posts, context) , // Replace Container() with your implementation of the bodyHomePage widget
    ),
    ),
    bottomNavigationBar: BottomNavigationBar(
    backgroundColor: kPrimaryColor,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: const TextStyle(
    color: Colors.white,
    ),
    unselectedLabelStyle: const TextStyle(
    color: Colors.grey,
    ),
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
