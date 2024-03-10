import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/EarningStar.dart';

Widget buildEarningStarsPage(
    List<EarningStar> earningStars, BuildContext context) {
  return ListView(
    children: [
      Padding(
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
      Padding(
        padding: EdgeInsets.only(right: 16.0, bottom: 20, top: 25),
        child: Text(
          "Earn points leading to stars through the following actions:",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16),
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: earningStars.length,
        itemBuilder: (context, index) {
          final item = earningStars[index];
          // To calculate if text will appear on the left or on the right
          bool isTextFirst = index % 2 == 0;
          return SizedBox(
            // Set height for all cards
            height: 180,
            child: Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: isTextFirst
                    ? [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.description,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Image.asset(item.imagePath, fit: BoxFit.cover),
                  ),
                ]
                    : [
                  Expanded(
                    flex: 2,
                    child: Image.asset(item.imagePath, fit: BoxFit.cover),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        item.description,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}
