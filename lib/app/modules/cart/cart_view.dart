import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    final cart = controller;
    final currency = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.brown.shade700,
      ),
      body: Obx(() {
        if (cart.cartItems.isEmpty) {
          return const Center(
            child: Text("🛒 Your cart is empty", style: TextStyle(fontSize: 18)),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (_, index) {
                  final item = cart.cartItems[index];
                  return Column(
                    children: [
                      const Divider(),
                      ListTile(
                        leading: item.imageUrl != null
                            ? Image.network(item.imageUrl!, width: 50, fit: BoxFit.cover)
                            : const Icon(Icons.fastfood),
                        title: Text(item.name),
                        subtitle: Text('${currency.format(item.price)} x ${item.quantity}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => cart.decreaseQuantity(item.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cart.addToCart(item),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ${currency.format(cart.total)}",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Confirm Checkout"),
                          content: Text("Proceed with total of ${currency.format(cart.total)}?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cart.clearCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("✅ Order placed!")),
                                );
                              },
                              child: const Text("Checkout"),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                    child: const Text("Checkout"),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
