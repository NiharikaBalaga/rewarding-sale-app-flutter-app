import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/RewardDetail.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_locations_header.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_progress_bar.dart';
import 'package:rewarding_sale_app_flutter_app/screen/reward/components/_rewards_details_list.dart';

Column bodyRewardPage(List<RewardDetail> rewardDetails, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      buildProgressBar(),
      const SizedBox(height: 25),
      sectionHeader('Rewards Details'),
      const SizedBox(height: 15),
      Expanded(child: rewardsDetailsList(context, rewardDetails)),
      const SizedBox(height: 15),
    ],
  );
}
