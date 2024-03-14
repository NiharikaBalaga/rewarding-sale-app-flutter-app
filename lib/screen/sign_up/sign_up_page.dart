import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import '../../constant.dart';
import '../../models/User.dart';
import '../../services/signupservice.dart';


class SignUpPage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Register New User',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // ConstrainedBox make sures that Column takes at least the screen height
          child: ConstrainedBox(
            constraints: BoxConstraints(
              // Here we take the screen height and the sets the minimum height of the ConstrainedBox
              minHeight: MediaQuery.of(context)
                  .size
                  .height, // Altura mínima igual al alto de la pantalla
            ),
            // IntrinsicHeight helps ot make sure that Column doesn't overflow the content
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/salespotterlogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // First name text field
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First name...',
                      hintStyle: TextStyle(
                        color: kSecondaryColor,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Last Name text field
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last name...',
                      hintStyle: TextStyle(
                        color: kSecondaryColor,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),

                  // Phone Number text field
                  // Phone Number text field
                  TextField(
                    controller: phonenumberController,
                    decoration: InputDecoration(
                      hintText: 'Phone number...',
                      hintStyle: TextStyle(
                        color: kSecondaryColor,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kTextColor,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone, // Set keyboard type to phone
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // Email address text field
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email address...',
                      hintStyle: TextStyle(
                        color: kSecondaryColor,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  // Sign Up button
                  InkWell(
                    onTap: () async {
                      // Check if any of the fields are empty
                      if (firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          phonenumberController.text.isEmpty ||
                          emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Please fill in all fields'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return; // Exit the function if any field is empty
                      }

                      User user = User(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                      );

                      Map<String, dynamic> signUpResult =
                      await SignUpApiService().signUp(
                        user.firstName,
                        user.lastName,
                        user.email,
                      );

                      if (signUpResult['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Signed up Successfully'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Save user data to local storage if needed
                        // Navigate to home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Error: ${signUpResult['error']}'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 17,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
