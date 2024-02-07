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
        child: _locationCard(location),
      ));
}

Card _locationCard(Location location) {
  return Card(
    elevation: 5,
    color: location.color,
    child: GridTile(
      child: Column(
        children: [
          _locationImage(location),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _locationName(location),
          ),
        ],
      ),
    ),
  );
}

Text _locationName(Location product) {
  return Text(
    product.name,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Container _locationImage(Location location) {
  return Container(
    height: 100,
    width: 120,
    padding: const EdgeInsets.all(18),
    child: Image.asset(
      location.imagePath,
      fit: BoxFit.cover,
      height: 80,
      width: 80,
    ),
  );
}
