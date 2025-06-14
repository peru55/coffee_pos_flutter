import 'package:coffee_pos/app/modules/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../../controllers/cart_controller.dart';

class CartFloatingButton extends StatelessWidget {
  const CartFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartController>();

    return Obx(() {
      final itemCount = cart.cartItems.length;

      return badges.Badge(
        position: badges.BadgePosition.topEnd(top: -6, end: -6),
        showBadge: itemCount > 0,
        ignorePointer: false,
        badgeAnimation: const badges.BadgeAnimation.scale(
          animationDuration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        badgeStyle: const badges.BadgeStyle(
          badgeColor: Colors.redAccent,
          padding: EdgeInsets.all(6),
        ),
        badgeContent: Text(
          itemCount.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.brown.shade700,
          onPressed: () => Get.to(() => CartView()),
          child: const Icon(Icons.shopping_cart),
        ),
      );
    });
  }
}


