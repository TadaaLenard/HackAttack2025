import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/customizedbutton.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:hackattack2025/datamodel.dart'; // Import your data model
import 'package:hackattack2025/navigation/route.dart';

class Sensorcart extends StatefulWidget {
  const Sensorcart({
    super.key,
  });

  @override
  State<Sensorcart> createState() => _SensorcartState();
}

class _SensorcartState extends State<Sensorcart> {
  final paddingval = 20.0;

  // Changed from _products to _cartItems (List of CartItem)
  // This is a sample cart for demonstration. In a real app, this would come from global state.
  final List<CartItem> _cartItems = [
    CartItem(
      product: const Product(
        imagePath: 'assets/images/air_quality_sensor.png',
        productName: 'Pm10/sensor pm2.5 sensor powder/pm2.5 laser sensor',
        soldQuantity: '100 sold',
        price: 'RM90.80',
      ),
      quantity: 2, // Example quantity in cart
    ),
    CartItem(
      product: const Product(
        imagePath: 'assets/images/sulfur_dioxide_sensor.png',
        productName: 'GS+3SO2 Sulphur Dioxide (SO2) Sensor',
        soldQuantity: '75 sold',
        price: 'RM120.00',
      ),
      quantity: 1, // Example quantity in cart
    ),
  ];

  // Callback to remove an item from the cart
  void _removeCartItem(CartItem item) {
    setState(() {
      _cartItems.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.product.productName} removed from cart.'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Callback to update quantity of an item in the cart
  void _updateCartItemQuantity(CartItem item, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.remove(item); // Remove if quantity drops to 0 or less
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${item.product.productName} removed from cart (quantity 0).'),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        item.quantity = newQuantity;
      }
    });
  }

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
                  'My Cart', // Changed title to 'My Cart'
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          // Search Bar (keeping for now, but might not be typical for a cart page)
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
                  // Iterate through _cartItems to build _CartCard for each
                  if (_cartItems.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Your cart is empty. Add some items!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ..._cartItems.map((cartItem) {
                      return _CartCard(
                        paddingval: paddingval,
                        cartItem: cartItem, // Pass the CartItem object
                        onRemove: _removeCartItem, // Pass callback for removal
                        onQuantityChanged:
                            _updateCartItemQuantity, // Pass callback for quantity update
                      );
                    }),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: paddingval, vertical: 10),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: GreenElevatedButton(
                text: 'Pay',
                onPressed: () {
                  if (_cartItems.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Your cart is empty. Cannot proceed to pay.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    double totalCartValue = _cartItems.fold(
                        0.0, (sum, item) => sum + item.totalItemPrice);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Proceeding to pay. Total: RM${totalCartValue.toStringAsFixed(2)}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    // Navigate to payment screen or checkout
                    Navigator.pushNamed(context, AppRoutes.sensorshoplist);
                  }
                },
                // navigateTo: AppRoutes.sensorcart // navigateTo should be handled by onPressed
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

// Renamed _ProductCard to _CartCard and updated its properties
class _CartCard extends StatefulWidget {
  final double paddingval;
  final CartItem cartItem; // Now takes a CartItem object
  final Function(CartItem) onRemove; // Callback for removing an item
  final Function(CartItem, int)
      onQuantityChanged; // Callback for quantity change

  const _CartCard({
    required this.paddingval,
    required this.cartItem,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  State<_CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<_CartCard> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController =
        TextEditingController(text: widget.cartItem.quantity.toString());
    _quantityController.addListener(_onQuantityTextChanged);
  }

  @override
  void didUpdateWidget(covariant _CartCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update text field if cartItem quantity changes from parent (e.g., item removed)
    if (widget.cartItem.quantity.toString() != _quantityController.text) {
      _quantityController.text = widget.cartItem.quantity.toString();
    }
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
      widget.onQuantityChanged(widget.cartItem, newQuantity);
    }
    // Optional: Handle invalid input (e.g., non-numeric) by showing an error
  }

  void _incrementQuantity() {
    widget.onQuantityChanged(widget.cartItem, widget.cartItem.quantity + 1);
  }

  void _decrementQuantity() {
    widget.onQuantityChanged(widget.cartItem, widget.cartItem.quantity - 1);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total price for this specific cart item
    final double totalItemPrice = widget.cartItem.totalItemPrice;

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
              widget
                  .cartItem.product.imagePath, // Use cartItem.product.imagePath
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.cartItem.product
                .productName, // Use cartItem.product.productName
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Text(
            widget.cartItem.product
                .soldQuantity, // Use cartItem.product.soldQuantity
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price: ${widget.cartItem.product.price}', // Display individual unit price
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'Total: RM${totalItemPrice.toStringAsFixed(2)}', // Display total price for this item
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
              SizedBox(
                width: double.infinity,
                child: GreenElevatedButton(
                  text: 'Remove', // Changed button text to 'Remove'
                  onPressed: () {
                    widget
                        .onRemove(widget.cartItem); // Call the remove callback
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
