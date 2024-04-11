import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/home.dart';
import 'package:rewarding_sale_app_flutter_app/screen/sign_up/sign_up_page.dart';

import '../../services/verifyotpservice.dart';

class HiddenText extends StatelessWidget {
  final String text;
  final int visiblePrefixLength;
  final int visibleSuffixLength;


  HiddenText({
    required this.text,
    this.visiblePrefixLength = 4,
    this.visibleSuffixLength = 3,
  });


  @override
  Widget build(BuildContext context) {
    String visiblePrefix = text.substring(0, visiblePrefixLength);
    String visibleSuffix = text.substring(text.length - visibleSuffixLength);
    return Text(
      '$visiblePrefix * * * * * $visibleSuffix',
      style: TextStyle(color: Colors.black, fontSize: 18),
    );
  }
}

class VerificationPage extends StatefulWidget {
  final String phoneNumber;


  const VerificationPage({Key? key, required this.phoneNumber})
      : super(key: key);



  @override
  _VerificationPageState createState() => _VerificationPageState();

}

class _VerificationPageState extends State<VerificationPage> {
  final defaultPinTheme = PinTheme(
    width: 46,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black, width: 1.5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'OTP Verification',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the back arrow to white
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          width: double.infinity,
          child: Column(
            children: [
              _iconThumbnail(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Enter the code sent to your number",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: HiddenText(
                  text: widget.phoneNumber,
                ),
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.indigo),
                  ),
                ),
                onCompleted: (pin) {
                  _verifyOtp(pin, formatPhoneNumber(widget.phoneNumber));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Image _iconThumbnail() {
    return Image.asset(
      'assets/images/salespotterlogo.png',
      width: 250,
      height: 250,
      alignment: Alignment.topCenter,
    );
  }

  void _verifyOtp(var otp, String formattedPhoneNumber) async {
    Map<String, dynamic> response = await VerifyOtpApiService().verifyOtp(
        formattedPhoneNumber, otp);
    bool success = response['success']!;
    bool isSignedUp = response['isSignedUp']!;
    String collatedPin = '';
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP Verified Successfully'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );
      collatedPin = '';
      if (!isSignedUp) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
        );
      } else {
        // TODO check is user is verified already / send to home screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } else {
      // Display error message
      collatedPin = '';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again'),
          duration: Duration(seconds: 2),
          backgroundColor: kError,
        ),
        
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerificationPage(phoneNumber: widget.phoneNumber),
        ),
      );
    }
  }

  String formatPhoneNumber(String phoneNumber) {
//formatting phone number
    if (phoneNumber.length >= 12) {
      return "${phoneNumber.substring(2, 5)}-${phoneNumber.substring(
          5, 8)}-${phoneNumber.substring(8, 12)}";
    } else {
// Handle cases where the phone number is not long enough
      return phoneNumber;
    }
  }
}