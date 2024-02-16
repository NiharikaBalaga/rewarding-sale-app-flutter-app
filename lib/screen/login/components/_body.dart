import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:get/get.dart';
import 'package:rewarding_sale_app_flutter_app/screen/login/otp_verification_page.dart';
import '../../../constant.dart';


import '../../../services/otpservice.dart';

class LoginController extends GetxController {
  var phoneNumber = "".obs;

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }
}

final loginController = LoginController();

Future<bool> _generateOtp(String phoneNumber) async {
  try {

    print("Received Phone Number : $phoneNumber");

    // Handle OTP generation response
    return OtpApiService().generateOtp(phoneNumber);
  } catch (error) {


    print("error : $error");
    return false;
  }
}

String formatPhoneNumber(String phoneNumber) {

if (phoneNumber.length >= 12) {
return "${phoneNumber.substring(2, 5)}-${phoneNumber.substring(5, 8)}-${phoneNumber.substring(8, 12)}";
} else {
// Handle cases where the phone number is not long enough
return phoneNumber;
}
}
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginBody(context),
    );
  }
}

Stack loginBody(BuildContext context) {
  final deviceWidth = MediaQuery.of(context).size.width;

  return Stack(
    children: <Widget>[
      Container(),
      SafeArea(
        child: GestureDetector(
          onTap: () => Get.back(),
        ),
      ),
      Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _iconThumbnail(),
              const SizedBox(height: 50),
              SizedBox(
                width: deviceWidth * .87,
                child: IntlPhoneField(
                  initialCountryCode: 'CA',
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (phone) {
                    loginController.setPhoneNumber(phone.completeNumber);
                  },
                ),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () async {

                  if (loginController.phoneNumber.value.isNotEmpty) {
                    var formattedPhoneNumber = formatPhoneNumber(loginController.phoneNumber.value);
                    bool otpGenerated = await _generateOtp(formattedPhoneNumber);
                    if (otpGenerated) {
                      // Navigate to VerificationPage
                        Get.to(() => VerificationPage(phoneNumber: loginController.phoneNumber.value));
                    }

                  } else {
                    Get.snackbar(
                      "Error",
                      "Phone number cannot be empty.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: kError,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
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