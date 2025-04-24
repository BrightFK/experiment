import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample data for the cart items
  final List<CartItem> _cartItems = [
    CartItem(
      name: 'Burger With Meat',
      price: 12230,
      quantity: 1,
      imageUrl: 'assets/images/hb/hb2.jpeg', // Replace with actual image URL
    ),
    CartItem(
      name: 'Ordinary Burger',
      price: 12230,
      quantity: 1,
      imageUrl: 'assets/images/hb/hb3.jpeg', // Replace with actual image URL
    ),
  ];

  // Function to calculate the total price
  double get _totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const Text('My Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black), // Make back button black
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black), // three dots
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Delivery Location Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Location',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {
                    // Handle change location
                  },
                  child: const Text('Change Location', style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),
            const Text(
              'Home',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Promo Code Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Promo Code',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange), // Change focus border color
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle apply promo code
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Cart Items List
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return _buildCartItemCard(item);
                },
              ),
            ),
            // Payment Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100], // Light background for summary
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Summary',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Items (2)', style: TextStyle(fontSize: 20)),
                      Text('\$${_totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee', style: TextStyle(fontSize: 20)),
                      Text('Free', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Discount', style: TextStyle(fontSize: 20)),
                      const Text('-\$10,900', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$${(_totalPrice - 10900).toStringAsFixed(0)}', // Apply Discount here
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
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
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true, // Or a variable to track selection
            onChanged: (bool? value) {
              // Handle checkbox change
            },
            activeColor: Colors.orange,
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.imageUrl),
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
                  item.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 16, color: Colors.orange),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.orange,),
                onPressed: () {
                  setState(() {
                    if (item.quantity > 1) {
                      item.quantity--;
                    }
                  });
                },
              ),
              Text(
                item.quantity.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.orange,),
                onPressed: () {
                  setState(() {
                    item.quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Cart Item Data Model
class CartItem {
  String name;
  double price;
  int quantity;
  String imageUrl;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
