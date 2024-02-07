import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/screen/home/components/_build_post_card.dart';

GridView postList(context, product) {
  return GridView.count(
    crossAxisCount: 1,
    children: List.generate(product.length, (index) {
      return GestureDetector(
        // Todo: complete onTap
        //onTap: () => Get.to(ProductDetail(product: product[index])),
        child: buildPostCard(product[index]),
      );
    }),
  );
}
