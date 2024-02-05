import 'package:flutter/material.dart';
import '../../constant.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Temporal posts list
  final List<Post> posts = [
    Post(
      name: 'Post 1',
      location: 'Location 1',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 2',
      location: 'Location 2',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 3',
      location: 'Location 3',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 4',
      location: 'Location 4',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 5',
      location: 'Location 5',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 6',
      location: 'Location 6',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
    Post(
      name: 'Post 7',
      location: 'Location 7',
      sale: 5,
      imagePath: 'assets/images/chicken.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Harry Potter',
          style: TextStyle(color: Colors.white, letterSpacing: 1.8),
        ),
        centerTitle: false,
        titleSpacing: 24.0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ListView
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return CardView(post: posts[index]);
              },
            ),
          ),
        ],
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
      ),
    );
  }
}

class Post {
  final String name;
  final String location;
  final double sale;
  final String imagePath;

  Post({
    required this.name,
    required this.location,
    required this.sale,
    required this.imagePath,
  });
}

class CardView extends StatelessWidget {
  final Post post;

  const CardView({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(7.0),
      child: ListTile(
        // Padding order: Left, Top, Right, Bottom
        contentPadding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
        // Row to locate image on the left and the product details and button on the right
        title: Row(
          children: [
            // Widget to show image
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                post.imagePath,
                width:
                    120.0, // Ajusta el tamaño de la imagen según tus preferencias
                height: 180.0,
                fit: BoxFit.fill,
              ),
            ),
            // Widget para mostrar los textos y el botón a la derecha
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.name),
                  Text(post.location),
                  Text('${post.sale}%'),
                ],
              ),
            ),
          ],
        ),
        // Details button
        trailing: ElevatedButton(
          onPressed: () {
            // Aquí puedes navegar a la pantalla de detalles del producto
            // Utiliza Navigator.push para ello
          },
          child: const Text('Details'),
        ),
      ),
    );
  }
}
