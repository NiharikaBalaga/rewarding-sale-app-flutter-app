import 'package:flutter/material.dart';
import 'package:rewarding_sale_app_flutter_app/models/Location.dart';

buildLocationCard(Location location) {
  return Padding(
      padding: const EdgeInsets.all(2),
      child: GestureDetector(
        // Todo: complete onTap
        /*onTap: () {
          Get.to(ProductDetail(product: product));
        },*/
        child: _productCard(location),
      ));
}

Card _productCard(Location location) {
  return Card(
    elevation: 8,
    color: location.color,
    child: GridTile(
      child: Column(
        children: [
          _imageIcon(location),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _title(location),
          ),
        ],
      ),
    ),
  );
}

Text _title(Location product) {
  return Text(
    product.name,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Container _imageIcon(Location location) {
  return Container(
    height: 100,
    width: 120,
    padding: const EdgeInsets.all(20),
    child: Image.asset(
      location.imagePath,
      fit: BoxFit.cover,
      height: 80,
      width: 80,
    ),
  );
}
