
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/services/locationservice.dart';

import '../services/api_services/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final AuthService authService = AuthService();
  final LocationService locationService = LocationService();
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }


  // Simulate an async task, such as loading data or performing initialization.
  Future<void> _initializeApp() async {
    var currentUser = await authService.getCurrentUser();
    if (currentUser.isNotEmpty) {
      var isBlocked = currentUser['isBlocked'] as bool?;
      var signedUp = currentUser['signedUp'] as bool?;
      // Init Location Service
      locationService.initializeAndStart();
      if (isBlocked != null && isBlocked) {
        // user is blocked
        Navigator.of(context).pushReplacementNamed('/blockedScreen');
      } else if (signedUp != null && !signedUp) {
        Navigator.of(context).pushReplacementNamed('/signUp');
      } else {
        // default Home Screen
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/salespotterlogo.png', // Replace with the path to your image.
              width: 450,
              height: 550,
              alignment: Alignment.bottomCenter,
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              child: FlareActor(
                'assets/images/Fading circles.gif', // Replace with the path to your Flare animation.
                animation: 'play', // Replace with the animation name.
              ),
            ),
          ],
        ),
      ),
    );
  }
}


