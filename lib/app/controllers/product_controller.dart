import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final supabase = Supabase.instance.client;

  var products = <Product>[].obs;
  var isLoading = false.obs;

  var cart = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;

    try {
      final response = await supabase.from('products').select();
      products.value =
          (response as List).map((item) => Product.fromMap(item)).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Product product) {
    cart.add(product);
    Get.snackbar('Cart', '${product.name} added');
  }

  void clearCart() => cart.clear();
}
