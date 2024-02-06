import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:get/get.dart';
import 'package:rewarding_sale_app_flutter_app/screen/login/otp_verification_page.dart';
import '../../../constant.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginController extends GetxController {
  var phoneNumber = "".obs;

  void setPhoneNumber(String value) {
    phoneNumber.value = value;
  }
}

final loginController = LoginController();

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
                onTap: () {
                  if (loginController.phoneNumber.value.isNotEmpty) {
                    Get.to(() => VerificationPage(
                      phoneNumber: loginController.phoneNumber.value,
                    ));
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
