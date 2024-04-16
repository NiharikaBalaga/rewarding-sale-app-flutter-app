// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
//
// Row buildSearchProducts() {
//
//   return Row(
//
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       // Search Bar
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black12, // Borde transparente
//                 width: 2.0, // Ancho del borde
//               ),
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//
//             child: Row(
//               children: [
//
//                 const Padding(
//
//                   padding: EdgeInsets.all(8.0),
//
//                   child: Icon(Icons.search, color: Colors.grey),
//                 ),
//                 Expanded(child: _showTextField()),
//               ],
//             ),
//           ),
//         ),
//       ),
//       // Icon Button for filtering
//       /*const SizedBox(width: 20),
//       Container(
//         color: Colors.grey.shade300,
//         height: 45,
//         width: 45,
//         child: _buildFilterBtn(),
//       ),*/
//     ],
//   );
// }
//
// _showTextField() {
//   return const TextField(
//
//     decoration: InputDecoration(
//         hintText: 'Search...',
//         border: InputBorder.none,
//         hintStyle: TextStyle(color: Colors.grey)),
//   );
// }
//
//

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import '../../../services/searchservice.dart'; // Replace 'your_app_path' with the actual path

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
                color: Colors.black12,
                width: 2.0,
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
                Expanded(
                  child: _showTextField((value) {
                    _performSearch(value);
                  }),
                ),
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

_showTextField(Function(String) onSubmitted) {
  return TextField(
    onSubmitted: onSubmitted,
    decoration: InputDecoration(
      hintText: 'Search...',
      border: InputBorder.none,
      hintStyle: TextStyle(color: Colors.grey),
    ),
  );
}

void _performSearch(String query) async {
  try {
    // Call the search service to fetch results
    final Map<String, dynamic> searchResults = (await SearchService.search(query)) as Map<String, dynamic>;
    // Process the search results here, e.g., update UI with the results
    print('Search Results: $searchResults');
  } catch (error) {
    // Handle errors if any
    print('Error during search: $error');
  }
}
