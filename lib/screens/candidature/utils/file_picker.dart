import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class FilePickerUtils {
  /// Picks a file with validation
  static Future<void> pickFile(Function(File) onSelected) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'svg'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);

        // Check file size (max 5MB for documents, 2MB for images)
        final fileSize = await file.length();
        final extension = result.files.single.extension?.toLowerCase();
        final maxSize = extension == 'pdf' || extension == 'svg'
            ? 5 * 1024 * 1024  // 5MB for PDF/SVG
            : 2 * 1024 * 1024; // 2MB for images

        if (fileSize > maxSize) {
          final maxSizeMB = maxSize ~/ (1024 * 1024);
          toast('Fichier trop volumineux. Taille maximum: ${maxSizeMB}MB');
          return;
        }

        // Additional validation for image files
        if (['jpg', 'jpeg', 'png'].contains(extension)) {
          // You could add image dimension validation here if needed
        }

        onSelected(file);
        toast('Fichier sélectionné avec succès');
      }
    } catch (e) {
      print('Erreur lors de la sélection du fichier: $e');
      toast('Erreur lors de la sélection du fichier. Veuillez réessayer.');
    }
  }

  /// Gets file size in MB
  static Future<double> getFileSizeInMB(File file) async {
    final bytes = await file.length();
    return bytes / (1024 * 1024);
  }

  /// Picks a PDF file specifically
  static Future<File?> pickPDFFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);

        // Check file size (max 5MB for PDF)
        final fileSize = await file.length();
        const maxSize = 5 * 1024 * 1024; // 5MB

        if (fileSize > maxSize) {
          toast('Fichier trop volumineux. Taille maximum: 5MB');
          return null;
        }

        return file;
      }
    } catch (e) {
      print('Erreur lors de la sélection du fichier PDF: $e');
      toast('Erreur lors de la sélection du fichier. Veuillez réessayer.');
    }
    return null;
  }
}