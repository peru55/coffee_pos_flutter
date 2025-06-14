import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  String selectedSize = '180 ml'; // Default selection

  final List<String> sizes = ['XS (150 ml)', 'S (180 ml)', 'M (240 ml)', 'L (360 ml)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coffee Image
          Hero(
            tag: widget.product.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.product.imageUrl ?? '',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Product Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Rich, foamy espresso",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.brown.shade700),
                ),
                const SizedBox(height: 16),

                // Coffee Sizes
                Wrap(
                  spacing: 8,
                  children: sizes.map((size) {
                    final selected = selectedSize == size;
                    return ChoiceChip(
                      label: Text(size),
                      selected: selected,
                      onSelected: (_) {
                        setState(() => selectedSize = size);
                      },
                      selectedColor: Colors.brown.shade300,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.brown.shade700,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  widget.product.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),

          const Spacer(),

          // Price + Add to Orders
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    // TODO: Add to cart or order
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.product.name} added to order')),
                    );
                  },
                  child: const Text("Add to orders"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
