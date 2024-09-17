import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<File?> pickImage({ImageSource source = ImageSource.gallery}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw ImageException('Error picking image: $e');
    }
  }

  Future<File> compressImage(File image) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath =
          '${dir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final compressedXFile = await FlutterImageCompress.compressAndGetFile(
        image.absolute.path,
        targetPath,
        minWidth: 800,
        minHeight: 600,
        quality: 80,
      );

      if (compressedXFile != null) {
        return File(compressedXFile.path);
      } else {
        throw ImageException('Error compressing image');
      }
    } catch (e) {
      throw ImageException('Error compressing image: $e');
    }
  }

  // Upload an image to Firebase Storage and return its URL
  Future<String> uploadImage(File image) async {
    try {
      final fileName =
          'images/${DateTime.now().millisecondsSinceEpoch}_${image.uri.pathSegments.last}';
      final uploadTask = _storage.ref(fileName).putFile(image);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Failed to upload image. Please try again.');
    }
  }
}

class ImageException implements Exception {
  final String message;
  ImageException(this.message);
}
