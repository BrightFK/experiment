import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Sample data for recent searches and orders
  final List<String> _recentSearches = [
    'Burger',
    'Fast food',
    'Dessert',
    'French',
    'Fastry',
  ];

  final List<Map<String, String>> _recentOrders = [
    {
      'name': 'Ordinary Burgers',
      'restaurant': 'Burger Restaurant',
      'rating': '4.9',
      'distance': '100m',
      'imageUrl': 'assets/images/hb/hb1.jpeg', // Replace
    },
    {
      'name': 'Ordinary Burgers',
      'restaurant': 'Burger Restaurant',
      'rating': '4.9',
      'distance': '100m',
      'imageUrl': 'assets/images/hb/hb2.jpeg', // Replace
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search Food', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Food',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.filter_list_sharp, color: Colors.orange,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange),
                ),
                fillColor: Colors.grey[100],
                filled: true,
              ),
            ),
            const SizedBox(height: 24),
            // Food Categories
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4, // Display 4 categories as in the image
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  // In real app, you would have a list of categories
                  final categories = ['Burger', 'Taco', 'Drink', 'Pizza'];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.orange : Colors.grey[200], // First item orange
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Recent Searches
            const Text(
              'Recent Searches',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return Chip(
                  label: Text(search),
                  onDeleted: () {
                    setState(() {
                      _recentSearches.remove(search);
                    });
                  },
                  deleteIcon: const Icon(Icons.cancel, size: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.grey),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // Recent Orders
            const Text(
              'My recent orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _recentOrders.length,
                itemBuilder: (context, index) {
                  final order = _recentOrders[index];
                  return _buildOrderCard(order);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, String> order) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(order['imageUrl']!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order['name']!,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  order['restaurant']!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(' ${order['rating']!}  |  ${order['distance']!}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
