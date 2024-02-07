import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PostPage(),
                //   ),
                // );
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
        body: MyWidget(),
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

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  File? _image;
  File? _image1;
  Future<void> _getProductImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image path: ${_image?.path}');
      }
    });
  }
  Future<void> _getPriceTagImage() async {
    final pickedFile1 = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile1 != null) {
        _image1 = File(pickedFile1.path);
        print('Image1 path: ${_image1?.path}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                // borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                // borderRadius: BorderRadius.circular(5.5),
              ),
              suffixIcon: Icon(
                Icons.place_rounded,
                color: Colors.blueGrey,
                size: 32,
              ),
              labelText: "Select your location",
              labelStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white12,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image Widget 1
              Expanded(
                child: Column(
                  children: [
                    _image != null ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54, // Set your desired border color
                          width: 2.0, // Set your desired border width
                        ),
                        borderRadius: BorderRadius.circular(5),
                        // Set your desired border radius
                      ),
                      child: Image.file(
                        _image!,
                        height: 130,
                        width: 130,
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54, // Set your desired border color
                          width: 2.0, // Set your desired border width
                        ),
                        borderRadius: BorderRadius.circular(5), // Set your desired border radius
                      ),
                      child: Image.asset(
                        'assets/images/noimageavailable.png', // Replace with the path to your asset image
                        height: 130,
                        width: 130,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _getProductImage,
                      label: const Text('Take Image',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(Icons.add_a_photo, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        elevation: 2,// Set your desired background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              // Image Widget 2
              Expanded(
                child: Column(
                  children: [
                    _image1 != null ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54, // Set your desired border color
                          width: 2.0, // Set your desired border width
                        ),
                        borderRadius: BorderRadius.circular(5), // Set your desired border radius
                      ),
                      child: Image.file(
                        _image1!,
                        height: 130,
                        width: 130,
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54, // Set your desired border color
                          width: 2.0, // Set your desired border width
                        ),
                        borderRadius: BorderRadius.circular(5), // Set your desired border radius
                      ),
                      child: Image.asset(
                        'assets/images/noimageavailable.png', // Replace with the path to your asset image
                        height: 130,
                        width: 130,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _getPriceTagImage,
                      label: const Text('Price Tag',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(Icons.add_a_photo, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        elevation: 2,// Set your desired background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 25,
          ),
          TextField(

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                // borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                // borderRadius: BorderRadius.circular(5.5),
              ),
              suffixIcon: Icon(
                Icons.local_offer,
                color: kPrimaryColor,
                size: 30,
              ),
              labelText: "Enter Product Name",
              labelStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white12,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                // borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                // borderRadius: BorderRadius.circular(5.5),
              ),
              suffixIcon: Icon(
                Icons.description_outlined,
                color: kPrimaryColor,
                size: 30,
              ),
              labelText: "Enter Product Description",
              labelStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white12,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Old Quantity Field
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    suffixIcon: Icon(
                      Icons.production_quantity_limits_rounded,
                      color: kPrimaryColor,
                    ),
                    labelText: "Old Quantity",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(width: 16),
              // New Quantity Field
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    suffixIcon: Icon(
                      Icons.production_quantity_limits_outlined,
                      color: kPrimaryColor,
                    ),
                    labelText: "New",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Old Quantity Field
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    suffixIcon: Icon(
                      Icons.price_change,
                      color: kPrimaryColor,
                    ),
                    labelText: "Old Price",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 16),
              // New Quantity Field
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: borderRadius(5),
                    ),
                    suffixIcon: Icon(
                      Icons.price_change_outlined,
                      color: kPrimaryColor,
                    ),
                    labelText: "New Price",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),

    ),

    );

  }
}
