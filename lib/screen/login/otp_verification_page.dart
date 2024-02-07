import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';
import 'package:rewarding_sale_app_flutter_app/screen/sign_up/sign_up_page.dart';

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



class VerificationPage extends StatelessWidget {
  final String phoneNumber;
  const VerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('OTP Verification',
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
                  style: TextStyle(color: Colors.black, fontSize: 18
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                // child: Text(
                //   phoneNumber,
                child: HiddenText(
                  text: phoneNumber,
                  //style: TextStyle(color: Colors.blueGrey, fontSize: 18
                  ),
                ),
              // ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.indigo),
                  ),

                ),
                onCompleted: (pin) {
                  debugPrint(pin);
                  // Navigate to the signup page here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
Image _iconThumbnail() {
  return Image.asset(
    'assets/images/salespotterlogo.png',
    width: 250,
    height: 250,
    alignment: Alignment.topCenter,
  );
}