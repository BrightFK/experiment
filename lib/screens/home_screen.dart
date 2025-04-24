import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _productsCollection;
  late Future<QuerySnapshot> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsCollection = _firestore.collection('products');
    _productsFuture = _productsCollection.get(); //get products
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background for the whole screen
      appBar: AppBar(
        backgroundColor: Colors.transparent, // No app bar background
        elevation: 0, // Remove app bar shadow
        title: const Text(
          "Discover Foods",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold, // Bold title
            fontSize: 24, // Increased font size
          ),
        ),
        centerTitle: false, // Align title to the left
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<QuerySnapshot>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              ); // Show loading indicator
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              ); // Show error message
            }
            if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No products available.'),
              ); // Handle empty state
            }

            final products = snapshot.data!.docs;

            return ListView.builder(
              // Use ListView.builder for better performance with large lists
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                // Instead of accessing data directly, create a map
                Map<String, dynamic> productData = product.data() as Map<String, dynamic>;

                return FoodCard(product: productData);
              },
            );
          },
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const FoodCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // More rounded corners
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.grey.withOpacity(0.2), // Subtle shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image Section
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // Use a ClipRRect for rounded corners on the image
                child:
                (product['images'] != null && product['images'].isNotEmpty)
                    ? Image.network(
                  product['images'][0], //show only the first image
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    //handle error
                    return const Center(child: Text("Image"));
                  },
                )
                    : const Center(child: Text('No Image')), //show no image text
              ),
            ),
            const SizedBox(width: 12),
            // Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product['name'] ?? 'No Name', //added null check
                    style: const TextStyle(
                      fontWeight: FontWeight.w600, // Semi-bold
                      fontSize: 18, // Increased font size
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product['description'] ?? 'No Description', //added null check
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 2, // Limit to 2 lines
                    overflow: TextOverflow.ellipsis, //show ellipsis
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['price'] != null
                        ? '\$${product['price'].toStringAsFixed(2)}'
                        : 'Price: N/A', //added null check
                    style: const TextStyle(
                      color: Colors.orange, // Use your theme color
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
