import 'dart:io';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart' show enrollmentStore;
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

class ReceiptPDFGenerator {
  static Future<void> generateAndDownloadReceipt(BuildContext context) async {
    try {
      // Vérifier les permissions
      if (await _requestStoragePermission()) {
        // Générer le PDF
        final pdfBytes = await _generateReceiptPDF();

        // Sauvegarder le fichier
        final filePath = await _savePDFToDevice(pdfBytes);

        if (filePath != null) {
          // Afficher le succès
          _showSuccessMessage(context, filePath);

          // Ouvrir automatiquement le PDF
          await OpenFilex.open(filePath);
        }
      } else {
        _showPermissionError(context);
      }
    } catch (e) {
      _showError(context, 'Erreur lors de la génération du PDF: $e');
    }
  }

  static Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status == PermissionStatus.granted;
    }
    return true; // iOS n'a pas besoin de permission pour Documents
  }

  static Future<List<int>> _generateReceiptPDF() async {
    final pdf = pw.Document();
    final now = DateTime.now();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // En-tête officiel
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: PdfColors.green700,
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'RÉPUBLIQUE DE CÔTE D\'IVOIRE',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Union - Discipline - Travail',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 12,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'COMMISSION ELECTORALE INDEPENDANTE',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 30),

              // Titre du document
              pw.Center(
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.orange, width: 2),
                    borderRadius: pw.BorderRadius.circular(5),
                  ),
                  child: pw.Text(
                    'RÉCÉPISSÉ D\'ENRÔLEMENT',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.orange,
                    ),
                  ),
                ),
              ),

              pw.SizedBox(height: 30),

              // Informations du récépissé
              pw.Container(
                padding: const pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Numéro de référence:', enrollmentStore.enrollmentReferenceNumber ?? 'N/A'),
                    _buildInfoRow('Date de soumission:', '${now.day}/${now.month}/${now.year}'),
                    _buildInfoRow('Heure de soumission:', '${now.hour}:${now.minute.toString().padLeft(2, '0')}'),
                    pw.SizedBox(height: 10),
                    _buildInfoRow('Nom complet:', '${enrollmentStore.firstName} ${enrollmentStore.lastName}'),
                    _buildInfoRow('Date de naissance:', enrollmentStore.dob ?? ''),
                    _buildInfoRow('Lieu de naissance:', enrollmentStore.placeOfBirth ?? ''),
                    _buildInfoRow('Numéro de pièce:', enrollmentStore.idNumber ?? ''),
                    pw.SizedBox(height: 10),
                    _buildInfoRow('Centre d\'enrôlement:', enrollmentStore.enrollmentCenter?.name ?? ''),
                    _buildInfoRow('District:', enrollmentStore.district?.name ?? ''),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Message important
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  color: PdfColors.orange100,
                  border: pw.Border.all(color: PdfColors.orange),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'INFORMATIONS IMPORTANTES',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.orange800,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      '• Ce récépissé atteste de votre demande d\'enrôlement sur les listes électorales.',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                    pw.Text(
                      '• Conservez précieusement ce document jusqu\'à la réception de votre carte d\'électeur.',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                    pw.Text(
                      '• Votre inscription sera validée après vérification par les services compétents.',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                    pw.Text(
                      '• Vous recevrez une notification une fois votre carte d\'électeur prête.',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),

              pw.Spacer(),

              // Pied de page
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: PdfColors.grey400)),
                ),
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Document généré automatiquement le ${now.day}/${now.month}/${now.year} à ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Commission Électorale Indépendante - Côte d\'Ivoire',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey600,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 150,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }

  static Future<String?> _savePDFToDevice(List<int> pdfBytes) async {
    try {
      Directory? directory;

      if (Platform.isAndroid) {
        // Pour Android, utiliser le dossier Downloads
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        // Pour iOS, utiliser le dossier Documents
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory != null) {
        final fileName = 'recepisse_enrolement_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(pdfBytes);
        return file.path;
      }

      return null;
    } catch (e) {
      print('Erreur lors de la sauvegarde: $e');
      return null;
    }
  }

  static void _showSuccessMessage(BuildContext context, String filePath) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.download_done, color: Colors.white),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Récépissé téléchargé avec succès'),
                  Text(
                    'Sauvegardé dans: ${filePath.split('/').last}',
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Ouvrir',
          textColor: Colors.white,
          onPressed: () => OpenFilex.open(filePath),
        ),
      ),
    );
  }

  static void _showPermissionError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            12.width,
            const Text('Permission de stockage requise'),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            12.width,
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}