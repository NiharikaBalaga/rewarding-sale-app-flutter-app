import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Row buildProgressBar() {
  // Manage the total star text earned by the user
  const int totalStars = 230;
  // Manage the progress text that it's display inside the progress bar
  const String progressText = "45000/100000";
  // Manage the values to fill up the progress bar
  const double progressValue = 45000 / 100000;
  // Manage the border radius of both, the progress bar container and its brackground
  const double progressBarRadius = 10;

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Column(
          children: [
            // Text with the number of stars
            const Text("$totalStars Stars", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 0),

            // Star icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 10),

            // Progress bar
            Container(
              height: 25, // Progress bar height
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(progressBarRadius),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.yellow, Colors.amber],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(progressBarRadius),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      progressText,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
