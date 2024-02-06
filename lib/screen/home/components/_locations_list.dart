import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_build_location_card.dart';

ListView locationsList(locations) {
  return ListView.builder(
      padding: const EdgeInsets.only(left: 0),
      itemCount: locations.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          // Todo: complete onTap
          //onTap: () => {Get.to(ProductDetail)},
          child: buildLocationCard(locations[index]),
        );
      });
}
