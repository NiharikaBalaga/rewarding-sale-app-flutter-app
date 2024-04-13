import 'package:flutter/material.dart';
import '../../constant.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            children: [
              const SizedBox(width: 50),
              Text(
                'About Us', // Customize the title
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        centerTitle: false,
        titleSpacing: 24.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Sale Spotter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Sale Spotter is your ultimate companion for discovering and sharing the best deals near shops. Our app rewards users for posting exclusive offers available in their vicinity.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Text(
                'How It Works',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                    color: kPrimaryColor
                ),
              ),
              SizedBox(height: 10),
              _buildImageWidget(
                'Discover Offers:',
                'Find amazing deals and discounts from nearby shops.',
                'assets/images/offers1.gif',
              ),
              SizedBox(height: 10),
              _buildImageWidget(
                'Post Offers:',
                'Share exclusive offers available near you and earn rewards.',
                'assets/images/offers.gif',
              ),
              SizedBox(height: 10),
              _buildImageWidget(
                'Get Rewards:',
                'Earn rewards points for each offer posted and redeemed.',
                'assets/images/star.gif',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String title, String description, String imageAsset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        // Placeholder for image widget (replace with your images)
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imageAsset), // Replace with your image asset
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
