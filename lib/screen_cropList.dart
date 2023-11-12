import 'package:flutter/material.dart';

import 'screen_detailsPage.dart';

class CardListPage extends StatelessWidget {
  const CardListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card List'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Handle the click action, e.g., navigate to a new page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailsPage(
                    title: 'State Management in Flutter',
                    imageUrl: 'https://placekitten.com/800/401',
                    pageContent:
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ...',
                  ),
                ),
              );
            },
            child: CardItem(
              imageUrl:
                  'https://placekitten.com/200/201', // Replace with your image URLs
              description: 'Description for Item $index',
            ),
          );
        },
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String description;

  const CardItem(
      {super.key, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imageUrl,
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
