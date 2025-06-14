import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadCart();
    ever(cartItems, (_) => saveCart());
  }

  void addToCart(CartItem item) {
    final index = cartItems.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh(); // trigger UI update
    } else {
      cartItems.add(item);
    }
  }

  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  void decreaseQuantity(String id) {
    final index = cartItems.indexWhere((e) => e.id == id);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(id);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  void saveCart() {
    final cartData = cartItems.map((item) => item.toMap()).toList();
    storage.write('cart', cartData);
  }

  void loadCart() {
    final savedCart = storage.read<List>('cart') ?? [];
    cartItems.assignAll(
      savedCart.map((e) => CartItem.fromMap(Map<String, dynamic>.from(e))).toList(),
    );
  }

  double get total => cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
}



// void saveCart() {
//   final cartData = cartItems.map((p) => {
//     'id': p.id,
//     'name': p.name,
//     'price': p.price,
//     //'description': p.description,
//     'image_url': p.imageUrl,
//   }).toList();
//
//   storage.write('cart', cartData);
// }