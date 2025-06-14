import 'package:coffee_pos/app/models/cart_model.dart';
import 'package:coffee_pos/app/modules/products/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_controller.dart';
import '../../utils/imageUploadService.dart';
import '../../widgets/cart_fab/cart_fab.dart';
import '../../widgets/category_selector/category_selector.dart';
import '../../widgets/product_cards/product_vertical_card.dart';
import '../../widgets/search_box/search_box.dart';
import '../auth/auth_controller.dart';

class ProductView extends StatelessWidget {
  final controller = Get.put(ProductController());
  final auth = Get.find<AuthController>();
  final cart = Get.find<CartController>();

  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown.shade50,
        elevation: 0,
        title: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${auth.name.value}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade800,
                  ),
                ),
                Text(
                  auth.role.value,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.brown.shade400,
                  ),
                ),
              ],
            ),
            Obx(() => ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: auth.photoUrl.value.isNotEmpty
                  ? Image.network(
                auth.photoUrl.value,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              )
                  : const Icon(Icons.person, size: 40, color: Colors.brown),
            ))

          ],
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.brown.shade800),
            onPressed: () => auth.logout(),
          ),
        ],
      ),

      //floatingActionButton: const CartFloatingButton(),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final filtered = controller.products.where((product) {
          final matchesQuery = product.name.toLowerCase().contains(searchQuery.value.toLowerCase());
          final matchesCategory = selectedCategory.value == 'All' ||
              product.category == selectedCategory.value;
          return matchesQuery && matchesCategory;
        }).toList();

        return Column(
          children: [
            SearchBox(
              controller: searchController,
              onChanged: (value) => searchQuery.value = value,
            ),
            const SizedBox(height: 12),
            CategorySelector(
              categories: ['All', 'Hot Drinks', 'Pastries'],
              onCategorySelected: (category) => selectedCategory.value = category,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.68,
                ),
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final product = filtered[i];
                  return ProductVerticalCard(
                    product: product,
                    onAdd: () {
                      cart.addToCart(CartItem.fromProduct(product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("✅ Added to cart")),
                      );
                    },
                    onTap: () {
                      Get.to(() => ProductDetailView(product: product));
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
