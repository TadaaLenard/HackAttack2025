import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart';
import 'package:hackattack2025/navigation/route.dart';

class Sensorshoplist extends StatefulWidget {
  const Sensorshoplist({
    super.key,
  });

  @override
  State<Sensorshoplist> createState() => _SensorshoplistState();
}

class _SensorshoplistState extends State<Sensorshoplist> {
  final paddingval = 20.0;

  // 2. Use List<Product> to define your products
  final List<Product> _products = const [
    Product(
      imagePath: 'assets/images/air_quality_sensor.png',
      productName: 'Pm10/sensor pm2.5 sensor powder/pm2.5 laser sensor',
      soldQuantity: '100 sold',
      price: 'RM90.80',
    ),
    Product(
      imagePath: 'assets/images/sulfur_dioxide_sensor.png',
      productName: 'GS+3SO2 Sulphur Dioxide (SO2) Sensor',
      soldQuantity: '75 sold',
      price: 'RM120.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(paddingval),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Industryappbar(showBackButton: true),
                Text(
                  'Sensor Products',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingval),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search by product name',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Iterate through the products list to build _ProductCard for each
                  ..._products.map((product) {
                    return _ProductCard(
                      paddingval: paddingval,
                      product: product, // Pass the entire product object
                    );
                  }),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: paddingval, vertical: 10),
            color: Colors.white,
            child: const SizedBox(
                width: double.infinity,
                child: GreenElevatedButton(
                  text: 'View My Cart',
                  navigateTo: AppRoutes.sensorcart,
                )),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

// New StatefulWidget for individual product cards to manage quantity
class _ProductCard extends StatefulWidget {
  final double paddingval;
  final Product product; // Now takes a Product object

  const _ProductCard({
    required this.paddingval,
    required this.product,
  });

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  int _quantity = 0; // Default quantity

  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _quantityController.text = _quantity.toString();
    _quantityController.addListener(_onQuantityTextChanged);
  }

  @override
  void dispose() {
    _quantityController.removeListener(_onQuantityTextChanged);
    _quantityController.dispose();
    super.dispose();
  }

  void _onQuantityTextChanged() {
    int? newQuantity = int.tryParse(_quantityController.text);
    if (newQuantity != null && newQuantity >= 0) {
      setState(() {
        _quantity = newQuantity;
      });
    }
    // Optional: Handle invalid input (e.g., non-numeric) by showing an error or reverting
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _quantityController.text = _quantity.toString();
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 0) {
        _quantity--;
        _quantityController.text = _quantity.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: widget.paddingval, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              widget.product.imagePath, // Use product.imagePath
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.product.productName, // Use product.productName
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            widget.product.soldQuantity, // Use product.soldQuantity
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.price, // Use product.price
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 20),
                      onPressed: _decrementQuantity,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: _incrementQuantity,
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                child: GreenElevatedButton(
                  text: 'Add to Cart',
                  navigateTo: AppRoutes.sensorcart,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
