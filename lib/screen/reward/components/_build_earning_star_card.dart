import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/EarningStar.dart';

// Widget to display inside the "Earning Stars" tab
Widget buildEarningStarsPage(
    List<EarningStar> earningStars, BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "Learn how to earn stars and unlock amazing rewards!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, bottom: 10, top: 30),
          child: Text(
            "Earn points leading to stars through the following actions:",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ),
        ListView.builder(
          physics:
              NeverScrollableScrollPhysics(), // Disable scrolling within ListView
          shrinkWrap:
              true, // Make ListView take up only as much space as its children
          itemCount: earningStars.length,
          itemBuilder: (context, index) {
            final item = earningStars[index];
            bool isTextFirst = index % 2 == 0; // Calculate text position
            return SizedBox(
              height: 120, // Fixed height for all cards
              child: Card(
                color: Colors.white, // White background for cards
                elevation: 0, // No elevation for cards
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: isTextFirst
                      ? [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.description),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child:
                                Image.asset(item.imagePath, fit: BoxFit.cover),
                          ),
                        ]
                      : [
                          Expanded(
                            flex: 1,
                            child:
                                Image.asset(item.imagePath, fit: BoxFit.cover),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(item.description),
                            ),
                          ),
                        ],
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
