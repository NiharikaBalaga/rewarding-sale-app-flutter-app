import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import '../../services/createnewpostservice.dart';
import '../../services/getplaceidservice.dart';
import '../../services/updateuserlocation.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
      ),
      body: MyWidget(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
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

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();

  static _MyWidgetState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyWidgetState>()!;
}

class _MyWidgetState extends State<MyWidget> {
  File? _image;
  File? _image1;
  String? _location;
  late String _placeId;
  // String placeId = 'ChIJTa2TPvn2K4gRiHG331ctW2I';
  TextEditingController _locationController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _oldQuantityController = TextEditingController();
  TextEditingController _newQuantityController = TextEditingController();
  TextEditingController _oldPriceController = TextEditingController();
  TextEditingController _newPriceController = TextEditingController();

  Future<void> _getProductImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image path: ${_image?.path}');
      }
    });
  }

  Future<void> _getPriceTagImage() async {
    final pickedFile1 =
    await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile1 != null) {
        _image1 = File(pickedFile1.path);
        print('Image1 path: ${_image1?.path}');
      }
    });
  }

  void _callCreateNewPostService() async {
    try {
      // Extract values from TextControllers
      String productName = _productNameController.text.trim();
      String productDescription = _productDescriptionController.text.trim();
      double oldPrice = double.tryParse(_oldPriceController.text.trim()) ?? 0.0;
      double newPrice = double.tryParse(_newPriceController.text.trim()) ?? 0.0;
      int newQuantity = int.tryParse(_newQuantityController.text.trim()) ?? 0;
      int oldQuantity = int.tryParse(_oldQuantityController.text.trim()) ?? 0;

      // Check if any of the required fields are empty
      if (productName.isEmpty ||
          productDescription.isEmpty ||
          oldPrice <= 0 ||
          newPrice <= 0 ||
          newQuantity <= 0 ||
          oldQuantity <= 0 ||
          _image == null ||
          _image1 == null) {
        // Show a snackbar or an alert dialog indicating that all fields are required
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('All fields are required.'),
            backgroundColor: Colors.red,
          ),
        );
        return; // Exit the function without proceeding further
      }

      File priceTagImage = _image1!;
      File productImage = _image!;
      String storePlaceId = _placeId;

      // Call the createNewPost function
      await NewPostService.createNewPost(
        productName: productName,
        oldPrice: oldPrice,
        newPrice: newPrice,
        priceTagImage: priceTagImage,
        productImage: productImage,
        newQuantity: newQuantity,
        oldQuantity: oldQuantity,
        storePlaceId: storePlaceId,
      );

      // If execution reaches this point, it means the function call was successful
      print('createNewPost function called successfully');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (error) {
      // Handle any errors that occur during the function call
      print('Error calling createNewPost function: $error');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // double latitude = position.latitude;
      // double longitude = position.longitude;

      double latitude = 43.445395;
      double longitude = -80.579977;

      String placeId = await getPlaceId(latitude, longitude);
      print('Place ID: $placeId');

      await LocationService.updateUserLocation(latitude, longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      String currentLocation = (placemarks[0].street ?? '') + ', ' + (placemarks[0].locality ?? '');

      String location = currentLocation.isEmpty ? 'Unknown' : currentLocation;
      setState(() {
        _location = location;
        _locationController.text = _location ?? '';
        _placeId = placeId;
      });

      print('User location: $_location');
      print('latitude: $latitude');
      print('longitude: $longitude');

      print('Place ID from func: $placeId');
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.place_rounded,
                      color: kPrimaryColor,
                      size: 32,
                    ),
                    onPressed: () {
                      _getCurrentLocation();
                      // placeAutoComplete("Dubai");
                    },
                  ),
                  labelText: "Get Your Current location",
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white12,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _image != null
                          ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Image.file(
                          _image!,
                          height: 130,
                          width: 130,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Image.asset(
                          'assets/images/noimageavailable.png',
                          height: 130,
                          width: 130,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _getProductImage,
                        label: const Text(
                          'Take Image',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(Icons.add_a_photo, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      _image1 != null
                          ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Image.file(
                          _image1!,
                          height: 130,
                          width: 130,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Image.asset(
                          'assets/images/noimageavailable.png',
                          height: 130,
                          width: 130,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: _getPriceTagImage,
                        label: const Text(
                          'Price Tag',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(Icons.add_a_photo, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 70,
              child: TextField(
                controller: _productNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: Icon(
                    Icons.local_offer,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  labelText: "Enter Product Name",
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white12,
                ),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 100,
              child: TextField(
                controller: _productDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: Icon(
                    Icons.description_outlined,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  labelText: "Enter Product Description",
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white12,
                ),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _oldQuantityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: Icon(
                          Icons.production_quantity_limits_rounded,
                          color: kPrimaryColor,
                        ),
                        labelText: "Old Quantity",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white12,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: TextField(
                      controller: _newQuantityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: Icon(
                          Icons.production_quantity_limits_outlined,
                          color: kPrimaryColor,
                        ),
                        labelText: "New Quantity",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white12,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      controller: _oldPriceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: Icon(
                          Icons.price_change,
                          color: kPrimaryColor,
                        ),
                        labelText: "Old Price",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white12,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: TextField(
                      controller: _newPriceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: Icon(
                          Icons.price_change_outlined,
                          color: kPrimaryColor,
                        ),
                        labelText: "New Price",
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white12,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _callCreateNewPostService,
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                child: Text(
                  "Create New Post",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],

        ),
      ),

    );

  }
}

