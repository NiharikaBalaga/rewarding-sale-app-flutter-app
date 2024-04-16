import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/models/Post.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
import 'package:rewarding_sale_app_flutter_app/services/getpostservice.dart';
import '../../services/createnewpostservice.dart';

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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: MyWidget(), // Directly embed MyWidget here
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kPrimaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      currentIndex:
          1, // Ensure this index is managed based on current page index
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
        // Handle navigation taps
      },
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
  String? _placeId;
  bool _isLoading = false;
  String _loadingMessage = '';

  TextEditingController _locationController = TextEditingController();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _oldQuantityController = TextEditingController();
  TextEditingController _newQuantityController = TextEditingController();
  TextEditingController _oldPriceController = TextEditingController();
  TextEditingController _newPriceController = TextEditingController();

  void _handleLocationPick(String placeId) {
    print('plaecId-state - ${placeId}');
    setState(() {
      _placeId = placeId;
      print('plaecId-state - ${placeId}');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startLoadingProcess() {
    setState(() {
      _isLoading = true;
      _loadingMessage = 'Post creation started';
    });
    Timer(Duration(seconds: 3), _continueLoadingProcess);
  }

  void _continueLoadingProcess() {
    setState(() {
      _loadingMessage = 'Validating location';
    });
    Timer(Duration(seconds: 3), () {
      setState(() {
        _loadingMessage = 'Validating Post';
      });
    });
  }

  // Function to handle place selection
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

  // // Inside your widget or wherever you want to call the service function
  Future<void> _callCreateNewPostService() async {
    _startLoadingProcess();
    /* setState(() {
      _isLoading = true; // Start loading
    }); */
    try {
      print('placeId: ${_placeId}');
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
        setState(() {
          _isLoading = false; // Stop the loading animation
        });
        return; // Exit the function without proceeding further
      }

      File priceTagImage = _image1!;
      File productImage = _image!;
      // int newQuantity = int.parse(_newQuantityController.text);
      // int oldQuantity = int.parse(_oldQuantityController.text);
      String storePlaceId = _placeId!;

      // Call the createNewPost function
      String? postId = await NewPostService.createNewPost(
          productName: productName,
          oldPrice: oldPrice,
          newPrice: newPrice,
          priceTagImage: priceTagImage,
          productImage: productImage,
          newQuantity: newQuantity,
          oldQuantity: oldQuantity,
          storePlaceId: storePlaceId);

      print("postId: $postId");

      if (postId != null) {
        // If execution reaches this point, it means the function call was successful
        print('createNewPost function called successfully');
        _checkPostStatus(postId);
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post.')),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error calling createNewPost function: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error calling createNewPost function: $error')),
      );

      // Handle any errors that occur during the function call
      /* print('Error calling createNewPost function: $error');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage())); */
    }
  }

  void _checkPostStatus(String postId) async {
    // Ensure postId is not null and valid
    print("_checkPostStatus: $postId");
    if (postId == null || postId.isEmpty) {
      _showSnackBar('Invalid post ID', Colors.red);
      return;
    }

    // Set loading state to true to show the loading indicator
    setState(() {
      _isLoading = true;
    });

    Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      try {
        Post post = await PostService.fetchPostById(postId);
        print("_checkPostStatus post: $post");
        if (post.status == 'POST_CREATED') {
          // Continue checking; the timer will keep running.
          print('Post still in creation process.');
        } else {
          // If status is not 'POST_CREATED', we need to act accordingly and cancel the timer.
          timer.cancel();
          setState(() {
            _isLoading = false;
          });

          if (post.status == 'POST_PUBLISHED') {
            _showSnackBar('Post published successfully', Colors.green);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (post.status == 'POST_FAILED') {
            _showSnackBar('Failed to publish post: ${post.postDeclinedReason}',
                Colors.red);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        }
      } catch (error) {
        // Handle exceptions by logging and showing snackbar message
        print('Error fetching post status: $error');
        _showSnackBar('Error fetching post status: $error', Colors.red);
        timer.cancel();
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _showSnackBar(String message, Color backgroundColor) {
    Duration duration =
        Duration(seconds: 5); // Default duration for non-error messages
    if (backgroundColor == Colors.red) {
      duration = Duration(seconds: 10); // Longer duration for error messages
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: [
          buildFormUI(), // Your form UI
          if (_isLoading) loadingOverlay(),
        ],
      ),
    );
  }

  Widget loadingOverlay() {
    return Positioned.fill(
      // This will make sure the overlay covers the entire screen area.
      child: Container(
        color: Colors.white.withOpacity(0.8), // Semi-transparent overlay
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment
              .center, // Ensure alignment is centered horizontally
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              _loadingMessage,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18, // Bigger font size
                fontWeight: FontWeight.bold, // Make text bold
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(child: placesAutoCompleteTextField()),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
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
              const SizedBox(width: 16),
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
          const SizedBox(height: 25),
          SizedBox(
            height: 70,
            child: TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: const Icon(
                  Icons.local_offer,
                  color: kPrimaryColor,
                  size: 30,
                ),
                labelText: "Enter Product Name",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white12,
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 100,
            child: TextField(
              controller: _productDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: const Icon(
                  Icons.description_outlined,
                  color: kPrimaryColor,
                  size: 30,
                ),
                labelText: "Enter Product Description",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white12,
              ),
            ),
          ),
          const SizedBox(height: 25),
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
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: const Icon(
                        Icons.production_quantity_limits_rounded,
                        color: kPrimaryColor,
                      ),
                      labelText: "Old Quantity",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white12,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: _newQuantityController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: const Icon(
                        Icons.production_quantity_limits_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "New Quantity",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white12,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
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
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: const Icon(
                        Icons.price_change,
                        color: kPrimaryColor,
                      ),
                      labelText: "Old Price",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white12,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: TextField(
                    controller: _newPriceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: const Icon(
                        Icons.price_change_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "New Price",
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white12,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _callCreateNewPostService,
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
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
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey, width: 0.5), // Add border color and width
        borderRadius: BorderRadius.circular(7.0), // Add border radius
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: _locationController,
        googleAPIKey: 'AIzaSyDBvFOnu4xQhn3EprY9llKqnfOkZkVw6ms',
        inputDecoration: const InputDecoration(
          hintText: "Search for a store",
          hintStyle: TextStyle(color: Colors.grey), // Update hint text color
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(10, 15, 15,
              10), // Adjust content padding for left alignment and height
          prefixIcon: Icon(Icons.location_on,
              color: kPrimaryColor, size: 35), // Add location icon
          alignLabelWithHint: true, // Align label with the hint text
        ),
        debounceTime: 400,
        countries: const ['ca'],
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print('prediction - ${prediction}');
          _handleLocationPick(prediction.placeId!);
        },
        itemClick: (Prediction prediction) {
          _locationController.text = prediction.description ?? "";
          _locationController.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: const Divider(),
        containerHorizontalPadding: 10,
      ),
    );
  }
}
