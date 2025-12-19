import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/screens/candidature/utils/file_picker.dart';
import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class DocumentsStep extends StatelessWidget {
  final CandidatureStore store;

  const DocumentsStep({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildStepTitle('Documents requis'),
            CommonWidgets.buildLegalReference('Article 54 - Pièces justificatives obligatoires'),
            16.height,
            _buildDocumentsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return Column(
      children: [
        CommonWidgets.buildWarningCard(
          'Documents obligatoires',
          'Tous les documents doivent être établis depuis moins de 3 mois et au format PDF, JPEG ou PNG (max 5MB chacun).',
          Icons.info,
          AppColors.warning,
        ),
        16.height,
        // Use documentsRequis instead of documentsSelonElection to show uploaded files
        ...store.documentsRequis.entries.map((entry) {
          final doc = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildDocumentUploadCard(doc),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDocumentUploadCard(DocumentRequis doc) {
    return Observer(
      builder: (_) => CommonWidgets.buildSectionCard(
        title: '${doc.nom}${doc.obligatoire ? ' *' : ''}',
        icon: Icons.description,
        children: [
          Text(doc.description, style: AppTextStyles.caption),
          if (doc.articleLegal != null) ...[
            4.height,
            Text(doc.articleLegal!, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
          ],
          12.height,
          _buildFileUploadSection(doc),
          if (doc.fichier != null) ...[
            12.height,
            _buildUploadedFileInfo(doc),
          ],
        ],
      ),
    );
  }

  Widget _buildFileUploadSection(DocumentRequis doc) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: doc.fichier != null ? AppColors.success.withOpacity(0.1) : AppColors.grey1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: doc.fichier != null ? AppColors.success : AppColors.grey2,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                doc.fichier != null ? Icons.check_circle : Icons.upload_file,
                color: doc.fichier != null ? AppColors.success : AppColors.primary,
                size: 24,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.fichier != null ? 'Document téléchargé' : 'Télécharger le document',
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: doc.fichier != null ? AppColors.success : AppColors.textPrimary,
                      ),
                    ),
                    4.height,
                    Text(
                      'Format accepté: PDF, JPEG, PNG (max 5MB)',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.height,
          SizedBox(
            width: double.infinity,
            child: AppButton(
              onTap: () => _pickDocumentFile(doc),
              color: doc.fichier != null ? AppColors.success : AppColors.primary,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    doc.fichier != null ? Icons.edit_document : Icons.upload_file,
                    color: Colors.white,
                    size: 18,
                  ),
                  8.width,
                  Text(
                    doc.fichier != null ? 'Modifier le fichier' : 'Sélectionner le fichier',
                    style: AppTextStyles.button,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedFileInfo(DocumentRequis doc) {
    final file = doc.fichier!;
    final fileName = file.path.split('/').last;
    final fileSize = _getFileSize(file);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.description, color: AppColors.success, size: 20),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTextStyles.body2.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.success,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                4.height,
                Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.success, size: 14),
                    4.width,
                    Text(
                      'Téléchargé: ${_formatDate(doc.dateUpload)}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                    Spacer(),
                    Text(
                      fileSize,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDocumentFile(DocumentRequis doc) async {
    try {
      await FilePickerUtils.pickFile((file) {
        store.uploadDocument(doc.code, file);
        // Auto-save progress after document upload
        store.saveCandidatureData();
      });
    } catch (e) {
      toast('Erreur lors du téléchargement du document');
    }
  }

  String _getFileSize(file) {
    try {
      final bytes = file.lengthSync();
      if (bytes < 1024) return '$bytes B';
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } catch (e) {
      return 'N/A';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}