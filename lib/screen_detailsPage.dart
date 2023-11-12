import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String pageContent;

  const DetailsPage(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.pageContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Image.asset(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    pageContent,
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  // Use a Column with ListTile widgets for a numbered list
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
