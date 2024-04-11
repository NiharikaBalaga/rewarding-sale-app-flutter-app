// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flare_flutter/flare_actor.dart';
// import 'package:get/get.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/login/login_page.dart';
// import 'package:rewarding_sale_app_flutter_app/screen/reward/reward.dart';
//
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//       getPages: [
//         GetPage(name: '/home', page: () => LoginScreen()),
//       ],
//     );
//   }
// }
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToHome();
//   }
//
//   // Simulate an async task, such as loading data or performing initialization.
//   Future<void> _simulateAsyncTask() async {
//     await Future.delayed(Duration(seconds: 4)); // Simulate a 2-second delay.
//   }
//
//   // Navigate to the main screen after the async task is completed.
//   void _navigateToHome() {
//     _simulateAsyncTask().then((_) {
//       Navigator.of(context).pushReplacementNamed('/home');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Customize the background color.
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/salespotterlogo.png', // Replace with the path to your image.
//               width: 450,
//               height: 550,
//               alignment: Alignment.bottomCenter,
//             ),
//             SizedBox(height: 20),
//             Container(
//               width: 200,
//               height: 200,
//               child: FlareActor(
//                 'assets/images/Fading circles.gif', // Replace with the path to your Flare animation.
//                 animation: 'play', // Replace with the animation name.
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/login/components/_body.dart';
import 'package:rewarding_sale_app_flutter_app/screen/login/login_page.dart';
import 'package:rewarding_sale_app_flutter_app/screen/sign_up/sign_up_page.dart';
import 'package:rewarding_sale_app_flutter_app/screen/splash_screen.dart';
import 'package:rewarding_sale_app_flutter_app/services/blocked_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/signUp', page: () => SignUpPage()),
        GetPage(name: '/blockedScreen', page: () => const BlockedMessageWidget()),
      ],
    );
  }
}

