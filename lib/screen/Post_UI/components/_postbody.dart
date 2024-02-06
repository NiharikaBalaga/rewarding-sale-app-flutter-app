import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/constant.dart';


class PostPageNew extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: postBody(context),
    );
  }
}

Stack postBody(BuildContext context) {
  final deviceWidth = MediaQuery
      .of(context)
      .size
      .width;
  return Stack(
      children: <Widget>[
        Scrollbar(
          thumbVisibility: true,
          child: const SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    suffixIcon: Icon(
                      Icons.place_rounded,
                      color: Colors.blueGrey,
                      size: 32,
                    ),
                    labelText: "Select your location",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    labelText: "No image Selected",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                    suffixIcon: Icon(
                      Icons.add_a_photo,
                      color: kPrimaryColor,
                      size: 31.0,
                      // Set the size as per your requirement
                    ),
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    labelText: "No Price tag image Selected",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                    suffixIcon: Icon(
                      Icons.add_a_photo,
                      color:kPrimaryColor,
                      size: 31.0, // Set the size as per your requirement
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    suffixIcon: Icon(
                      Icons.local_offer,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    labelText: "Enter Product Name",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    suffixIcon: Icon(
                      Icons.description_outlined,
                      color: kPrimaryColor,
                      size: 30,
                    ),
                    labelText: "Enter Product Description",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white12,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Old Quantity Field
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            // borderRadius: BorderRadius.circular(5.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          suffixIcon: Icon(
                            Icons.production_quantity_limits_rounded,
                            color: kPrimaryColor,
                          ),
                          labelText: "Old Quantity",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(width: 16),
                    // New Quantity Field
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            // borderRadius: BorderRadius.circular(5.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            // borderRadius: BorderRadius.circular(5.5),
                          ),
                          suffixIcon: Icon(
                            Icons.production_quantity_limits_outlined,
                            color: kPrimaryColor,
                          ),
                          labelText: "New",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Old Quantity Field
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            // borderRadius: BorderRadius.circular(5.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            // borderRadius: BorderRadius.circular(5.5),
                          ),
                          suffixIcon: Icon(
                            Icons.price_change,
                            color: kPrimaryColor,
                          ),
                          labelText: "Old Price",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 16),
                    // New Quantity Field
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            // borderRadius: BorderRadius.circular(5.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor),
                            // borderRadius: borderRadius(5),
                          ),
                          suffixIcon: Icon(
                            Icons.price_change_outlined,
                            color: kPrimaryColor,
                          ),
                          labelText: "New Price",
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ]
  );
}
