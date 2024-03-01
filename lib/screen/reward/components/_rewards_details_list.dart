import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_build_reward_details_card.dart';

ListView rewardsDetailsList(context, rewardDetails) {
  return ListView.builder(
    itemCount: rewardDetails.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        // Todo: complete onTap
        //onTap: () => Get.to(ProductDetail(product: product[index])),
        child: buildRewardDetailCard(rewardDetails[index]),
      );
    },
  );
}
