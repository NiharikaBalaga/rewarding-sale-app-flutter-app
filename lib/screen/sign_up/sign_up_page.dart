import 'package:flutter/material.dart';
import '../../constant.dart';
import 'package:rewarding_sale_app_flutter_app/screen/Post_UI/Post_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Register New User',
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
                  const TextField(
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
                  const TextField(
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
                  const TextField(
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
                  ),
                  const SizedBox(height: 10.0),

                  // Email address text field
                  const TextField(
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 25),
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
