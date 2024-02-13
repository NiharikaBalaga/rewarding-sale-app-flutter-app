import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


Row buildSearchProducts() {

  return Row(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Search Bar
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12, // Borde transparente
                width: 2.0, // Ancho del borde
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),

            child: Row(
              children: [

                const Padding(

                  padding: EdgeInsets.all(8.0),

                  child: Icon(Icons.search, color: Colors.grey),
                ),
                Expanded(child: _showTextField()),
              ],
            ),
          ),
        ),
      ),
      // Icon Button for filtering
      /*const SizedBox(width: 20),
      Container(
        color: Colors.grey.shade300,
        height: 45,
        width: 45,
        child: _buildFilterBtn(),
      ),*/
    ],
  );
}

_showTextField() {
  return const TextField(

    decoration: InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey)),
  );
}

// Icon Button for filtering
/*IconButton _buildFilterBtn() {
  return IconButton(
    alignment: Alignment.center,
    icon: const Icon(CupertinoIcons.sort_down, size: 20),
    onPressed: () => print("Filter clicked"),
    tooltip: "Filter",
    iconSize: 35,
    padding: const EdgeInsets.all(10),
    color: Colors.teal,
  );
}*/
