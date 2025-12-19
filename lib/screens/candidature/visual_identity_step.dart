import 'package:cei_mobile/screens/candidature/utils/file_picker.dart';
import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class VisualIdentityStep extends StatelessWidget {
  final CandidatureStore store;

  const VisualIdentityStep({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildStepTitle('Identité visuelle de candidature'),
            CommonWidgets.buildLegalReference('Articles 25-26 - Couleur, sigle et symbole'),
            16.height,
            CommonWidgets.buildWarningCard(
              'Restrictions importantes',
              '• L\'utilisation combinée des trois couleurs du drapeau national (Orange, Blanc, Vert) est interdite\n'
                  '• Les armoiries de la République ne peuvent pas être utilisées\n'
                  '• Votre couleur, sigle et symbole doivent être uniques',
              Icons.warning,
              AppColors.error,
            ),
            24.height,
            _buildVisualIdentitySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualIdentitySection() {
    return CommonWidgets.buildSectionCard(
      title: 'Configuration visuelle',
      icon: Icons.palette,
      children: [
        _buildEnhancedColorPicker(),
        16.height,
        CommonWidgets.buildTextField(
          label: 'Sigle de campagne *',
          hint: 'Ex: ABC2025',
          initialValue: store.sigleChoisi ?? '',
          onChanged: (value) => store.sigleChoisi = value,
        ),
        16.height,
        CommonWidgets.buildFileUploadCard(
          'Symbole de campagne',
          'Logo ou image symbolique (PNG, JPG, SVG - max 2MB)',
          store.symboleChoisi,
              () => _pickFile(),
        ),
        16.height,
        _buildVisualPreview(),
      ],
    );
  }

  Widget _buildEnhancedColorPicker() {
    final List<Color> allowedColors = [
      Colors.blue,
      Colors.red,
      Colors.purple,
      Colors.pink,
      Colors.indigo,
      Colors.teal,
      Colors.cyan,
      Colors.brown,
      Colors.grey[700]!,
      Colors.black,
      Colors.yellow[700]!,
      Colors.lime[700]!,
      Colors.amber[800]!,
      Colors.deepOrange,
      Colors.blueGrey,
    ];

    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Couleur pour le bulletin de vote *', style: AppTextStyles.body2),
          8.height,

          // Current color preview
          Row(
            children: [
              Container(
                width: 60,
                height: 48,
                decoration: BoxDecoration(
                  color: store.couleurBulletin != null
                      ? Color(int.parse(store.couleurBulletin!.replaceAll('#', '0xFF')))
                      : AppColors.grey2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey3, width: 2),
                ),
                child: store.couleurBulletin != null
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
              16.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.couleurBulletin != null
                          ? 'Couleur sélectionnée: ${store.couleurBulletin}'
                          : 'Aucune couleur sélectionnée',
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: store.couleurBulletin != null
                            ? AppColors.success
                            : AppColors.textSecondary,
                      ),
                    ),
                    4.height,
                    Builder(
                      builder: (context) => AppButton(
                        onTap: () => _showColorPickerDialog(context),
                        color: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.palette, color: Colors.white, size: 16),
                            8.width,
                            const Text(
                              'Choisir une couleur',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          12.height,

          // Color palette grid
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Couleurs disponibles',
                  style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
                ),
                12.height,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: allowedColors.length,
                  itemBuilder: (context, index) {
                    final color = allowedColors[index];
                    final colorHex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
                    final isSelected = store.couleurBulletin == colorHex;

                    return GestureDetector(
                      onTap: () {
                        store.couleurBulletin = colorHex;
                        toast('Couleur sélectionnée: $colorHex');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.grey3,
                            width: isSelected ? 3 : 1,
                          ),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ] : null,
                        ),
                        child: isSelected
                            ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                            : null,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          8.height,

          // Restrictions notice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: AppColors.warning, size: 16),
                8.width,
                Expanded(
                  child: Text(
                    'Cette couleur doit être différente de celle des cartes électorales et unique parmi tous les candidats.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.warning),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    final List<Color> colorOptions = [
      Colors.blue,
      Colors.red,
      Colors.purple,
      Colors.pink,
      Colors.indigo,
      Colors.teal,
      Colors.cyan,
      Colors.brown,
      Colors.grey[700]!,
      Colors.black,
      Colors.yellow[700]!,
      Colors.lime[700]!,
      Colors.amber[800]!,
      Colors.deepOrange,
      Colors.blueGrey,
      Colors.green,
      Colors.lightBlue,
      Colors.deepPurple,
      Colors.orange,
      Colors.blueGrey[800]!,
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choisir une couleur'),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: colorOptions.length,
              itemBuilder: (context, index) {
                final color = colorOptions[index];
                final colorHex = '#${color.value.toRadixString(16).substring(2).toUpperCase()}';

                return GestureDetector(
                  onTap: () {
                    store.couleurBulletin = colorHex;
                    Navigator.of(context).pop();
                    toast('Couleur sélectionnée: $colorHex');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grey3, width: 2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildVisualPreview() {
    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aperçu de votre identité visuelle',
              style: AppTextStyles.body2.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            12.height,
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: store.couleurBulletin != null
                        ? Color(int.parse(store.couleurBulletin!.replaceAll('#', '0xFF')))
                        : AppColors.grey2,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.grey3),
                  ),
                ),
                16.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.sigleChoisi?.isNotEmpty == true ? store.sigleChoisi! : 'Votre sigle',
                        style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${store.nom} ${store.prenoms}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    await FilePickerUtils.pickFile((file) => store.symboleChoisi = file);
  }
}