import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/RewardDetail.dart';

buildRewardDetailCard(RewardDetail rewardDetail) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: SizedBox(
      height: 78, // Custom height for the card
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Text - rewardStarsAmountText
              Container(
                width: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B2A72),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _rewardStarsAmountText(rewardDetail),
                ),
              ),
              // Right Text - rewardDescriptionText
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(right: 5, bottom: 10, top: 10, left: 10),
                  child: _rewardDescriptionText(rewardDetail),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _rewardStarsAmountText(RewardDetail rewardDetail) {
  return Text(
    rewardDetail.starsAmount.toString(),
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    ),
    textAlign: TextAlign.center,
  );
}

Widget _rewardDescriptionText(RewardDetail rewardDetail) {
  // Splitting the text based on the first occurrence of " - "
  var parts = rewardDetail.starsDescription.split(" - ");
  String firstPart = parts[0];
  String secondPart =
      (parts.length > 1) ? " - ${parts.sublist(1).join(" - ")}" : "";

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: firstPart,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        TextSpan(
          text: secondPart,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    ),
    softWrap: true,
  );
}
