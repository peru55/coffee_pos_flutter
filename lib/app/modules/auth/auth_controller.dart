import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  var isLoggedIn = false.obs;


  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = supabase.auth.currentSession != null;
    supabase.auth.onAuthStateChange.listen((data) {
      isLoggedIn.value = data.session != null;
    });
  }

  final name = ''.obs;
  final role = ''.obs;
  final photoUrl = ''.obs;

  Future<void> loadUserProfile() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        final response = await supabase
            .from('users')
            .select('name, role')
            .eq('id', userId)
            .single();

        name.value = response['name'] ?? '';
        role.value = response['role'] ?? '';
        photoUrl.value = response['profile_image'] ?? '';
        print('Loaded user profile: ${name.value}, ${role.value}');
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }


  Future<void> register(String email, String password, String name, String role) async {
    try {
      final res = await supabase.auth.signUp(email: email, password: password);
      final user = res.user;
      if (user != null) {
        // Insert into custom users table
        await supabase.from('users').insert({
          'id': user.id,
          'email': user.email,
          'name': name,
          'role': role,
          'profile_image': '',
        });

        Get.snackbar('Success', 'Account created');
        await loadUserProfile();
        Get.offAllNamed('/products');
      }
    } catch (e) {
      Get.snackbar('Registration Failed', e.toString());
    }
  }


  Future<void> login(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.session != null) {
        await loadUserProfile();
        Get.offAllNamed('/products');
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  void logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed('/login');
  }

}
