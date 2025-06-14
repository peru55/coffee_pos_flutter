// lib/main.dart
import 'package:coffee_pos/app/modules/products/product_view.dart';
import 'package:coffee_pos/app/theme/coffee_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/controllers/cart_controller.dart';
import 'app/controllers/product_controller.dart';
import 'app/modules/auth/auth_controller.dart';
import 'app/modules/auth/auth_screen.dart';
import 'app/modules/auth/login_screen.dart';
import 'app/modules/auth/register_screen.dart';
import 'app/modules/main_navigation.dart';

const SUPABASE_URL = 'https://orvaoquxunofhvbsacve.supabase.co';
const ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ydmFvcXV4dW5vZmh2YnNhY3ZlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk2NDQ4ODgsImV4cCI6MjA2NTIyMDg4OH0.4061h6x1P_Zm2Lm-KYt43IEyvmF8WHvj-qqodPR6DWs';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: ANON_KEY,
  );

  await GetStorage.init(); // Initialize storage

  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(CartController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'Coffee POS',
      theme: coffeeTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: auth.isLoggedIn.value ? '/products' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/products', page: () => const MainNavigation()),
      ],
    ));
  }
}

//Get.offAll(() => const MainNavigation());
