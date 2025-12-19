import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

class ConfirmationView extends StatefulWidget {
  final String receiptNumber;
  final String selectedType;
  final VoidCallback onFinish;

  const ConfirmationView({
    super.key,
    required this.receiptNumber,
    required this.selectedType,
    required this.onFinish,
  });

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  final GlobalKey _receiptKey = GlobalKey();
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            const Text('Réclamation Soumise', style: AppTextStyles.h2),
            const SizedBox(height: 16),
            const Text(
              'Votre réclamation a été enregistrée avec succès.',
              style: AppTextStyles.body1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            RepaintBoundary(
              key: _receiptKey,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDBF86),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text('Récépissé', style: AppTextStyles.h4, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Divider(),
                    Text(widget.receiptNumber, style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold)),
                    const Divider(),
                    const SizedBox(height: 12),
                    _buildReceiptDetail('Type', widget.selectedType),
                    _buildReceiptDetail('Date', '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                    _buildReceiptDetail('Centre', 'Centre Principal'), // Replace with actual center if available
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Conservez ce récépissé pour suivre l\'état de votre réclamation',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text('Partager', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _shareReceipt,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: _isDownloading
                        ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                        : const Icon(Icons.download, color: Colors.white),
                    label: Text(
                      _isDownloading ? 'Téléchargement...' : 'Télécharger',
                      style: const TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: _isDownloading ? null : _downloadReceipt,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
              elevation: 0.0,
              color: AppColors.primary,
              onTap: widget.onFinish,
              width: double.infinity,
              child: Text('Terminer', style: boldTextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> _shareReceipt() async {
    // try {
    //   final receiptImage = await _captureReceiptImage();
    //   final tempDir = await getTemporaryDirectory();
    //   final file = await File('${tempDir.path}/receipt_${widget.receiptNumber}.png').create();
    //   await file.writeAsBytes(receiptImage);
    //
    //   await Share.shareXFiles(
    //     [XFile(file.path)],
    //     text: 'Récépissé de réclamation: ${widget.receiptNumber}',
    //     subject: 'Récépissé de réclamation',
    //   );
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Erreur lors du partage: $e')),
    //   );
    // }
  }

  Future<void> _downloadReceipt() async {
    // setState(() {
    //   _isDownloading = true;
    // });
    //
    // try {
    //   final receiptImage = await _captureReceiptImage();
    //   final directory = await getExternalStorageDirectory();
    //   final file = File('${directory?.path}/receipt_${widget.receiptNumber}.png');
    //   await file.writeAsBytes(receiptImage);
    //
    //   setState(() {
    //     _isDownloading = false;
    //   });
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Récépissé sauvegardé dans: ${file.path}'),
    //       duration: const Duration(seconds: 3),
    //     ),
    //   );
    // } catch (e) {
    //   setState(() {
    //     _isDownloading = false;
    //   });
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Erreur lors du téléchargement: $e')),
    //   );
    // }
  }

  Future<Uint8List> _captureReceiptImage() async {
    final RenderRepaintBoundary boundary =
    _receiptKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}