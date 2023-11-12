import 'package:flutter/material.dart';

import 'screen_cropList.dart';
import 'screen_detailsPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DashboardItem> items = [
    DashboardItem(
      title: 'Tomatoes',
      imageUrl: 'assets/tomatoes.jpg',
      itemContent: '''
      1. First point with some content.
      2. Second point with more content.
      
      Subheading:
      This is a subheading with additional details.
      
      3. Another numbered point.
      4. Final point to showcase formatting.
    ''',
    ),
    DashboardItem(
      title: 'Onions',
      imageUrl: 'assets/red-onion-whole-isolated-white.jpg',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 2',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 3',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 4',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 5',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 6',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 7',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 8',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
    DashboardItem(
      title: 'Item 9',
      imageUrl: 'https://placekitten.com/200/30',
      itemContent: 'assets/tomatoes.jpg',
    ),
  ];

  List<DashboardItem> filteredItems = [];


  @override
  void initState() {
    filteredItems = items;
    super.initState();
  }

  void filterItems(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* 
      appBar: AppBar(
        title: const Text('Dashboard'),
      ), */
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterItems,
              decoration: const InputDecoration(
                labelText: 'Search to filter crops',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle the click action, e.g., navigate to a new page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          title:
                              'Post Harvest for ${filteredItems[index].title}',
                          imageUrl: filteredItems[index].imageUrl,
                          pageContent: filteredItems[index].itemContent,
                        ),
                      ),
                    );
                  },
                  child: CardItem(
                    item: filteredItems[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final String imageUrl;
  final String itemContent;

  DashboardItem({required this.itemContent, required this.title, required this.imageUrl});
}

class CardItem extends StatelessWidget {
  final DashboardItem item;

  CardItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0, // Adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.asset(
                item.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                item.title,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
