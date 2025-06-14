// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:path/path.dart' as path;
//
// Future<String?> uploadImage() async {
//   final result = await FilePicker.platform.pickFiles(
//     type: FileType.image,
//     allowMultiple: false,
//   );
//
//   if (result != null && result.files.single.path != null) {
//     final file = File(result.files.single.path!);
//     final fileName = path.basename(file.path);
//     final userId = Supabase.instance.client.auth.currentUser?.id ?? 'guest';
//
//     final uniqueFileName = '$userId-${DateTime.now().millisecondsSinceEpoch}-$fileName';
//
//     try {
//       await Supabase.instance.client.storage
//           .from('product-images')
//           .upload(uniqueFileName, file);
//
//       final publicUrl = Supabase.instance.client.storage
//           .from('product-images')
//           .getPublicUrl(uniqueFileName);
//
//       return publicUrl;
//     } catch (e) {
//       print('Upload failed: $e');
//       return null;
//     }
//   } else {
//     print('No file selected.');
//     return null;
//   }
// }
