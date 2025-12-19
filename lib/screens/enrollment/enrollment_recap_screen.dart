import 'package:cei_mobile/common_widgets/file_preview_card.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart' show appStore, enrollmentStore;
import 'package:cei_mobile/services/receip_pdf_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:signature/signature.dart';

class EnrollmentRecapScreen extends StatefulWidget {
  const EnrollmentRecapScreen({
    super.key,
  });

  @override
  State<EnrollmentRecapScreen> createState() => _EnrollmentRecapScreenState();
}

class _EnrollmentRecapScreenState extends State<EnrollmentRecapScreen> {
  bool _termsAccepted = false;
  late SignatureController _signatureController;
  bool _isSigned = false;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: AppColors.primary,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Observer(
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Récapitulatif",
                          style: boldTextStyle(
                              size: 36, letterSpacing: 2, color: Colors.black)),
                      Text("d\'enrôlement",
                          style: boldTextStyle(
                            size: 36,
                            letterSpacing: 2,
                            color: Colors.black,
                          )),
                      50.height,
                      // Header message
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            12.width,
                            Expanded(
                              child: Text(
                                'Veuillez vérifier toutes vos informations avant de soumettre votre demande d\'enrôlement.',
                                style:
                                    primaryTextStyle(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.height,
                      // ID Photo and Verification Section with Face Comparison
                      _buildSectionCard(
                        title: 'Photo d\'identité',
                        icon: Icons.face,
                        content: [
                          _buildDetailRow(
                              'Vérification faciale:',
                              enrollmentStore.faceVerified
                                  ? 'Vérifiée ✓'
                                  : 'Non vérifiée'),
                          16.height,
                          // Face comparison component
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Comparaison des photos',
                                  style: boldTextStyle(size: 16),
                                ),
                                12.height,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Document face photo
                                    if (enrollmentStore.documentFacePhoto !=
                                        null)
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              enrollmentStore
                                                  .documentFacePhoto!,
                                              height: 100,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          8.height,
                                          Text('Photo du document',
                                              style:
                                                  secondaryTextStyle(size: 12)),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                                Icons.person_outline,
                                                size: 40,
                                                color: Colors.grey),
                                          ),
                                          8.height,
                                          Text('Photo du document',
                                              style:
                                                  secondaryTextStyle(size: 12)),
                                        ],
                                      ),

                                    // Similarity indicator
                                    Column(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: enrollmentStore.faceVerified
                                                ? Colors.green[100]
                                                : Colors.orange[100],
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${enrollmentStore.faceVerified ? '95' : '70'}%",
                                              style: boldTextStyle(
                                                color:
                                                    enrollmentStore.faceVerified
                                                        ? Colors.green[700]
                                                        : Colors.orange[700],
                                              ),
                                            ),
                                          ),
                                        ),
                                        8.height,
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: enrollmentStore.faceVerified
                                                ? Colors.green[100]
                                                : Colors.orange[100],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            enrollmentStore.faceVerified
                                                ? 'Validé'
                                                : 'À vérifier',
                                            style: TextStyle(
                                              color:
                                                  enrollmentStore.faceVerified
                                                      ? Colors.green[700]
                                                      : Colors.orange[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Live ID photo
                                    if (enrollmentStore.idPhoto != null)
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              enrollmentStore.idPhoto!,
                                              height: 100,
                                              width: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          8.height,
                                          Text('Photo prise',
                                              style:
                                                  secondaryTextStyle(size: 12)),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.camera_alt,
                                                size: 40, color: Colors.grey),
                                          ),
                                          8.height,
                                          Text('Photo prise',
                                              style:
                                                  secondaryTextStyle(size: 12)),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(1), // Step 2 in store is index 1
                      ),
                      16.height,

                      // Personal Information (Step 3 in the store)
                      _buildSectionCard(
                        title: 'Informations personnelles',
                        icon: Icons.person,
                        content: [
                          _buildDetailRow('Nom:', enrollmentStore.lastName),
                          _buildDetailRow('Prénom:', enrollmentStore.firstName),
                          _buildDetailRow(
                              'Genre:', enrollmentStore.gender ?? ''),
                          _buildDetailRow('Lieu de naissance:',
                              enrollmentStore.placeOfBirth),
                          _buildDetailRow('Ville:', enrollmentStore.city ?? ''),
                          _buildDetailRow(
                              'Commune:', enrollmentStore.commune ?? ''),
                          _buildDetailRow('Quartier:', enrollmentStore.quarter),
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(2), // Step 3 in store is index 2
                      ),
                      16.height,

                      // Parent Information (Step 4 in the store)
                      _buildSectionCard(
                        title: 'Informations des parents',
                        icon: Icons.family_restroom,
                        content: [
                          _buildDetailRow(
                              'Nom du père:', enrollmentStore.lastNameFather),
                          _buildDetailRow('Prénom du père:',
                              enrollmentStore.firstNameFather),
                          _buildDetailRow('Date de naissance du père:',
                              enrollmentStore.birthdateFather),
                          _buildDetailRow('Lieu de naissance du père:',
                              enrollmentStore.birthplaceFather),
                          16.height,
                          _buildDetailRow('Nom de la mère:',
                              enrollmentStore.lastNameMother),
                          _buildDetailRow('Prénom de la mère:',
                              enrollmentStore.firstNameMother),
                          _buildDetailRow('Date de naissance de la mère:',
                              enrollmentStore.birthdateMother),
                          _buildDetailRow('Lieu de naissance de la mère:',
                              enrollmentStore.birthplaceMother),
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(3), // Step 4 in store is index 3
                      ),
                      16.height,

                      // Enrollment Center (Step 5 in the store)
                      _buildSectionCard(
                        title: 'Centre d\'enrôlement',
                        icon: Icons.location_on,
                        content: [
                          _buildDetailRow('District:',
                              enrollmentStore.district?.name ?? ''),
                          _buildDetailRow('Centre:',
                              enrollmentStore.enrollmentCenter?.name ?? ''),
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(4), // Step 5 in store is index 4
                      ),
                      16.height,

                      // ID Document (Step 1 in the store)
                      _buildSectionCard(
                        title: 'Document d\'identité',
                        icon: Icons.document_scanner,
                        content: [
                          _buildDetailRow(
                              'Type de pièce:', enrollmentStore.idType ?? ''),
                          _buildDetailRow('Numéro:', enrollmentStore.idNumber),
                          _buildDetailRow(
                              'Date d\'expiration:',
                              enrollmentStore.expireDate != null
                                  ? '${enrollmentStore.expireDate!.day}/${enrollmentStore.expireDate!.month}/${enrollmentStore.expireDate!.year}'
                                  : ''),
                          8.height,
                          Text('Photos:', style: secondaryTextStyle()),
                          8.height,
                          if (enrollmentStore.idFrontPhoto != null &&
                              enrollmentStore.idBackPhoto != null)
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    enrollmentStore.idFrontPhoto!,
                                    height: 80,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                8.width,
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    enrollmentStore.idBackPhoto!,
                                    height: 80,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          8.height,
                          Text("Extrait d'acte de naissance",
                              style: secondaryTextStyle()),
                          if (enrollmentStore.step1Files.isNotEmpty)
                            FilePreviewCard(
                                file: enrollmentStore.step1Files.first),
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(0), // Step 1 in store is index 0
                      ),
                      16.height,

                      // Address Information (Step 6 in the store)
                      _buildSectionCard(
                        title: 'Adresse actuelle',
                        icon: Icons.home,
                        content: [
                          _buildDetailRow('Adresse:', enrollmentStore.address),
                          _buildDetailRow(
                              'Ville:', enrollmentStore.addressCity ?? ''),
                          _buildDetailRow(
                              'Commune:', enrollmentStore.addressCommune ?? ''),
                          _buildDetailRow('Quartier:',
                              enrollmentStore.addressQuarter ?? ''),
                          // 8.height,
                          // Text(
                          //     "Certificat de résidence",
                          //     style: secondaryTextStyle()),
                          // if (enrollmentStore.step6FilesCertificat.isNotEmpty)
                          //   FilePreviewCard(file: enrollmentStore.step6FilesCertificat.first),
                          // 8.height,
                          // Text(
                          //     "Facture CIE/SODECI",
                          //     style: secondaryTextStyle()),
                          // if (enrollmentStore.step6FilesCIE.isNotEmpty)
                          //   FilePreviewCard(file: enrollmentStore.step6FilesCIE.first)
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(5), // Step 6 in store is index 5
                      ),
                      16.height,

                      // Contact Information (Step 7 in the store)
                      _buildSectionCard(
                        title: 'Coordonnées personnelles',
                        icon: Icons.contact_phone,
                        content: [
                          _buildDetailRow(
                              'Téléphone:', enrollmentStore.phoneNumber),
                          if (enrollmentStore.secondPhoneNumber.isNotEmpty)
                            _buildDetailRow('Téléphone (2):',
                                enrollmentStore.secondPhoneNumber),
                          _buildDetailRow('Email:', enrollmentStore.email),
                          _buildDetailRow(
                              'Profession:', enrollmentStore.profession),
                        ],
                        onEdit: () => enrollmentStore
                            .goToStep(6), // Step 7 in store is index 6
                      ),
                      30.height,

                      // Terms and Conditions Checkbox
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: _termsAccepted,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              setState(() {
                                _termsAccepted = value ?? false;
                                if (!value!) {
                                  // Clear signature if terms are unchecked
                                  _signatureController.clear();
                                  _isSigned = false;
                                }
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Je certifie sur l\'honneur que les informations fournies sont exactes et complètes. Je comprends que toute fausse déclaration peut entraîner le rejet de ma demande.',
                              style: secondaryTextStyle(),
                            ),
                          ),
                        ],
                      ),

                      // Signature section (only visible when terms are accepted)
                      if (_termsAccepted) ...[
                        20.height,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.draw,
                                        color: AppColors.primary, size: 20),
                                    8.width,
                                    Text(
                                      'Votre signature',
                                      style: boldTextStyle(size: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Veuillez signer dans le cadre ci-dessous:',
                                      style: secondaryTextStyle(),
                                    ),
                                    12.height,
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey[300]!),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Signature(
                                          controller: _signatureController,
                                          backgroundColor: Colors.white,
                                          height: 180,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                    8.height,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              _signatureController.clear();
                                              _isSigned = false;
                                            });
                                          },
                                          icon: const Icon(Icons.refresh,
                                              size: 16),
                                          label: const Text('Effacer'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey[700],
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                        ),
                                        8.width,
                                        TextButton.icon(
                                          onPressed: () {
                                            // Check if signature is not empty
                                            if (_signatureController
                                                .isNotEmpty) {
                                              setState(() {
                                                _isSigned = true;
                                              });
                                              // You could save the signature as an image here if needed
                                              // For example:
                                              // saveSignature();
                                            } else {
                                              toast(
                                                  'Veuillez signer avant de confirmer');
                                            }
                                          },
                                          icon:
                                              const Icon(Icons.check, size: 16),
                                          label: const Text('Confirmer'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.primary,
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      30.height,
                    ],
                  ),
                ),
              ),
              _buildNavigationButtons(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onTap: () {
                enrollmentStore.previousStep();
              },
              elevation: 0.0,
              color: Colors.grey[300],
              child:
                  Text('Précédent', style: boldTextStyle(color: Colors.black)),
            ),
          ),
          8.width,
          Expanded(
            child: Observer(builder: (c) {
              // Check if both terms are accepted and signature is complete
              bool canSubmit = _termsAccepted && _isSigned;

              return AppButton(
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onTap: canSubmit
                    ? () {
                        if (enrollmentStore.isSubmitting) return;
                        enrollmentStore.submitEnrollment().then((_) {
                          if (enrollmentStore.isEnrollmentComplete) {
                            //enrollmentStore.resetEnrollment();
                            context.go('/enrollment/success');
                          }
                        });
                      }
                    : null,
                elevation: 0.0,
                color: canSubmit ? AppColors.primary : Colors.grey[400],
                child: enrollmentStore.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text('Soumettre',
                        style: boldTextStyle(color: Colors.white)),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> content,
    required VoidCallback onEdit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.primary, size: 20),
                    8.width,
                    Text(
                      title,
                      style: boldTextStyle(size: 14),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text('Modifier'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.secondary,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: secondaryTextStyle(),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: primaryTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to save signature if needed
  Future<void> saveSignature() async {
    if (_signatureController.isEmpty) return;

    // Get the signature as PNG bytes
    final signatureBytes = await _signatureController.toPngBytes();

    if (signatureBytes != null) {
      // Now you can save these bytes to a file or send them to your API
      // For example:
      // final tempDir = await getTemporaryDirectory();
      // final file = await File('${tempDir.path}/signature.png').create();
      // await file.writeAsBytes(signatureBytes);
    }
  }
}

class EnrollmentSuccessScreen extends StatelessWidget {
  const EnrollmentSuccessScreen({super.key});

  // Méthode pour télécharger le récépissé
  Future<void> _downloadReceipt(BuildContext context) async {
    try {
      // Afficher un indicateur de chargement


      // Simuler le téléchargement (remplacez par votre logique réelle)
      final downloadFile = await FileDownloader.downloadFile(
          url:
              "https://cei-api.zenapi.net/api/v1/enrolements/ticket/${appStore.enrollmentData?.id.validate()}",
          name: "répissé.pdf", //(optional)
          onProgress: (s,d){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          onDownloadCompleted: (String path) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.download_done, color: Colors.white),
                    12.width,
                    const Text('Récépissé téléchargé avec succès'),
                  ],
                ),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          onDownloadError: (String error) {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.white),
                    12.width,
                    const Text('Erreur lors du téléchargement'),
                  ],
                ),
                backgroundColor: AppColors.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          });
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              12.width,
              const Text('Erreur lors du téléchargement'),
            ],
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.05),

                        // Lottie Animation
                        Lottie.asset(
                          'assets/animations/enrollment_success.json',
                          height: constraints.maxHeight * 0.2,
                          repeat: false,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),

                        // Success Title
                        Text(
                          'Félicitations !',
                          style:
                              boldTextStyle(size: 28, color: AppColors.primary),
                          textAlign: TextAlign.center,
                        ),
                        16.height,

                        // Success Message
                        Text(
                          'Votre demande d\'enrôlement a été soumise avec succès.',
                          style: primaryTextStyle(size: 16),
                          textAlign: TextAlign.center,
                        ),
                        20.height,

                        // Details Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      color: AppColors.primary),
                                  12.width,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Traitement en cours',
                                          style: boldTextStyle(),
                                        ),
                                        4.height,
                                        Text(
                                          'Votre demande est en cours de traitement. Ce processus peut prendre du temps.',
                                          style: secondaryTextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              16.height,
                              Row(
                                children: [
                                  const Icon(Icons.notifications_active,
                                      color: AppColors.primary),
                                  12.width,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Notification',
                                          style: boldTextStyle(),
                                        ),
                                        4.height,
                                        Text(
                                          'Vous recevrez une notification lorsque votre inscription sera validée.',
                                          style: secondaryTextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        20.height,

                        // Reference number card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.primary.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.receipt_long,
                                  color: AppColors.primary, size: 28),
                              12.width,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Numéro de référence',
                                      style: boldTextStyle(
                                          color: AppColors.primary),
                                    ),
                                    4.height,
                                    Observer(builder: (_) {
                                      return Text(
                                        enrollmentStore
                                                .enrollmentReferenceNumber ??
                                            'N/A',
                                        style: boldTextStyle(size: 18),
                                      );
                                    }),
                                    4.height,
                                    Text(
                                      'Conservez ce numéro pour suivre votre demande',
                                      style: secondaryTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.height,

                        // Récépissé card avec bouton de téléchargement
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.secondary.withOpacity(0.3))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.receipt,
                                      color: AppColors.secondary, size: 28),
                                  12.width,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Récépissé d\'enrôlement',
                                          style: boldTextStyle(
                                              color: AppColors.secondary),
                                        ),
                                        4.height,
                                        Text(
                                          'Votre demande d\'enrôlement a été soumise avec succès. Ce récépissé atteste de votre démarche et sera votre justificatif en attendant la validation de votre inscription par les autorités compétentes.',
                                          style: secondaryTextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              16.height,
                              // Bouton de téléchargement
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.download,
                                      color: Colors.white, size: 20),
                                  label: const Text(
                                    'Télécharger le récépissé',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () => _downloadReceipt(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        20.height,

                        // Boutons d'action
                        Column(
                          children: [
                            // Bouton retour à l'accueil
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon:
                                    const Icon(Icons.home, color: Colors.white),
                                label: const Text('Retour à l\'accueil'),
                                onPressed: () {
                                  context.go("/home");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Méthode pour partager le récépissé
  Future<void> _shareReceipt(BuildContext context) async {
    try {
      // Ici vous pouvez implémenter la logique de partage
      // Par exemple avec le package share_plus:
      // await Share.share(
      //   'Mon récépissé d\'enrôlement - Référence: ${enrollmentStore.enrollmentReferenceNumber}',
      //   subject: 'Récépissé d\'enrôlement CEI',
      // );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.share, color: Colors.white),
              12.width,
              const Text('Fonction de partage disponible bientôt'),
            ],
          ),
          backgroundColor: AppColors.info,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              12.width,
              const Text('Erreur lors du partage'),
            ],
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
