// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:path/path.dart' as path;
// import 'package:image_cropper/image_cropper.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:image_picker_for_web/image_picker_for_web.dart';
//
// class UploadImageButton extends StatelessWidget {
//   final void Function(String imageUrl) onUploaded;
//   final String productId;
//
//   const UploadImageButton({
//     super.key,
//     required this.onUploaded,
//     required this.productId,
//   });
//
//   Future<void> _handleUpload(BuildContext context) async {
//     final user = Supabase.instance.client.auth.currentUser;
//     final role = user?.userMetadata?['role'] ?? 'cashier';
//
//     if (role != 'admin') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("❌ Only admins can upload product images")),
//       );
//       return;
//     }
//
//     Uint8List? bytes;
//     String fileName = '';
//
//     if (kIsWeb) {
//       final picker = ImagePicker();
//       final picked = await picker.pickImage(source: ImageSource.gallery);
//
//       if (picked != null) {
//         bytes = await picked.readAsBytes();
//         fileName = path.basename(picked.path);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("❌ No image selected on web")),
//         );
//         return;
//       }
//     }
//     else {
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         allowMultiple: false,
//       );
//
//       if (result == null || result.files.single.path == null) {
//         print("No file selected.");
//         return;
//       }
//
//       final originalFile = File(result.files.single.path!);
//
//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: originalFile.path,
//         aspectRatioPresets: [
//           CropAspectRatioPreset.square,
//           CropAspectRatioPreset.original,
//         ],
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: 'Crop Image',
//             toolbarColor: Colors.brown,
//             toolbarWidgetColor: Colors.white,
//             lockAspectRatio: false,
//           ),
//           IOSUiSettings(title: 'Crop Image'),
//         ],
//       );
//
//       if (croppedFile == null) return;
//       bytes = await File(croppedFile.path).readAsBytes();
//       fileName = path.basename(croppedFile.path);
//     }
//
//     final userId = user?.id ?? 'guest';
//     final uniqueFileName = '$userId-${DateTime.now().millisecondsSinceEpoch}-$fileName';
//
//     try {
//       await Supabase.instance.client.storage
//           .from('product-images')
//           .uploadBinary(uniqueFileName, bytes);
//
//       final publicUrl = Supabase.instance.client.storage
//           .from('product-images')
//           .getPublicUrl(uniqueFileName);
//
//       await Supabase.instance.client
//           .from('products')
//           .update({'image_url': publicUrl})
//           .eq('id', productId);
//
//       onUploaded(publicUrl);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("✅ Image uploaded and product updated")),
//       );
//     } catch (e) {
//       print('Upload error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("❌ Upload failed: $e")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: () => _handleUpload(context),
//       icon: const Icon(Icons.upload),
//       label: const Text('Upload Image'),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.brown.shade700,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
// }
