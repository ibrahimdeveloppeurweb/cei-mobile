import 'dart:io';
import 'package:cei_mobile/screens/candidature/utils/file_picker.dart';
import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';


class DeclarationCandidatureStep extends StatefulWidget {
  final CandidatureStore store;

  const DeclarationCandidatureStep({Key? key, required this.store}) : super(key: key);

  @override
  State<DeclarationCandidatureStep> createState() => _DeclarationCandidatureStepState();
}

class _DeclarationCandidatureStepState extends State<DeclarationCandidatureStep> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.buildStepTitle('Déclaration de candidature'),
          CommonWidgets.buildLegalReference('Article 51 - Déclaration de candidature à l\'élection présidentielle'),
          24.height,
          _buildDeclarationSection(),
        ],
      ),
    );
  }

  Widget _buildDeclarationSection() {
    return Observer(
      builder: (_) => Column(
        children: [
          CommonWidgets.buildSectionCard(
            title: 'Déclaration personnelle de candidature',
            icon: Icons.description,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                        8.width,
                        Text(
                          'Information importante',
                          style: AppTextStyles.body2.copyWith(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    12.height,
                    Text(
                      'Chaque candidat à l\'élection du Président de la République est tenu de produire une déclaration de candidature revêtue de sa signature dûment légalisée.',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
              20.height,

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.assignment, color: Colors.orange[700], size: 20),
                        8.width,
                        Text(
                          'Exigences légales',
                          style: AppTextStyles.body2.copyWith(
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    12.height,
                    Text(
                      '• Document signé par le candidat\n'
                          '• Signature légalisée par une autorité compétente\n'
                          '• Format PDF de haute qualité\n'
                          '• Document lisible et complet',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
              ),

              24.height,

              _buildFileUploadSection(),

              if (widget.store.declarationCandidature != null) ...[
                20.height,
                _buildUploadedFileInfo(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileUploadSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.store.declarationCandidature != null
              ? AppColors.success
              : AppColors.grey2,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            widget.store.declarationCandidature != null
                ? Icons.file_present
                : Icons.file_upload_outlined,
            size: 48,
            color: widget.store.declarationCandidature != null
                ? AppColors.success
                : AppColors.primary,
          ),
          16.height,
          Text(
            widget.store.declarationCandidature != null
                ? 'Déclaration téléchargée'
                : 'Télécharger votre déclaration de candidature',
            style: AppTextStyles.h4.copyWith(
              fontWeight: FontWeight.w600,
              color: widget.store.declarationCandidature != null
                  ? AppColors.success
                  : AppColors.textPrimary,
            ),
          ),
          8.height,
          Text(
            'Format accepté: PDF uniquement (max 5MB)',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          20.height,
          SizedBox(
            width: double.infinity,
            child: AppButton(
              onTap: _pickDeclarationFile,
              color: widget.store.declarationCandidature != null
                  ? AppColors.success
                  : AppColors.primary,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.store.declarationCandidature != null
                        ? Icons.edit_document
                        : Icons.upload_file,
                    color: Colors.white,
                    size: 20,
                  ),
                  12.width,
                  Text(
                    widget.store.declarationCandidature != null
                        ? 'Modifier le fichier'
                        : 'Sélectionner le fichier',
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

  Widget _buildUploadedFileInfo() {
    final file = widget.store.declarationCandidature!;
    final fileName = file.path.split('/').last;
    final fileSize = _getFileSize(file);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: AppColors.success, size: 20),
              8.width,
              Text(
                'Fichier téléchargé avec succès',
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          12.height,
          Row(
            children: [
              Icon(Icons.description, color: AppColors.success, size: 16),
              8.width,
              Expanded(
                child: Text(
                  fileName,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          4.height,
          Row(
            children: [
              Icon(Icons.storage, color: AppColors.success, size: 16),
              8.width,
              Text(
                'Taille: $fileSize',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _pickDeclarationFile() async {
    try {
      final result = await FilePickerUtils.pickPDFFile();
      if (result != null) {
        widget.store.setDeclarationCandidature(result);
        await widget.store.saveCandidatureData(); // Auto-save progress
        setState(() {});
        toast('Déclaration téléchargée avec succès');
      }
    } catch (e) {
      toast('Erreur lors du téléchargement du fichier');
    }
  }

  String _getFileSize(File file) {
    final bytes = file.lengthSync();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}