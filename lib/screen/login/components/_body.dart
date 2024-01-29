import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../components/_input_fields.dart';
import '../../../constant.dart';
import 'package:get/get.dart';

Stack loginBody(context) {
  final deviceWidth = MediaQuery.of(context).size.width;

  return Stack(
    children: <Widget>[
      Container(),
      SafeArea(
          child: GestureDetector(
        onTap: () => Get.back(),
      )),
      Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _iconThumbnail(),
              const SizedBox(height: 50),
              SizedBox(
                width: deviceWidth * .87,
              child:
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  )
                )
              ),
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 25),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
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


CustomInputField imputFieldLogin(field) {
  return CustomInputField(
    null,
    const Icon(
      Icons.person,
      color: Colors.black,
      size: 30,
    ),
    field,
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
