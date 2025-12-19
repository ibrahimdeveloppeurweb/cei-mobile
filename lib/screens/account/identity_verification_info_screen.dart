import 'package:cei_mobile/common_widgets/floating_bottom_action_widget.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';


class IdentityVerificationInfoScreen extends StatefulWidget {
  const IdentityVerificationInfoScreen({super.key});

  @override
  State<IdentityVerificationInfoScreen> createState() => _IdentityVerificationInfoScreenState();
}

class _IdentityVerificationInfoScreenState extends State<IdentityVerificationInfoScreen> {

  // Méthode pour afficher le modal de confirmation
  void _showExitConfirmationModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titre
                Text(
                  'Quitter la vérification ?',
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                16.height,

                // Description
                Text(
                  'Quitter mettra fin à votre processus de vérification. Voulez-vous vraiment quitter ?',
                  style: AppTextStyles.body1.copyWith(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                32.height,

                // Boutons
                Column(
                  children: [
                    // Bouton Continuer la vérification
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        height: 48,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Fermer le modal
                        },
                        elevation: 0.0,
                        color: AppColors.primary,
                        child: Text(
                          'Continuer la vérification',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    16.height,

                    // Bouton Quitter
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // Fermer le modal
                        context.goNamed(AppRoutes.login);// Quitter l'écran
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        alignment: Alignment.center,
                        child: Text(
                          'Quitter',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton:FloatButtomActionWidjet(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => _showExitConfirmationModal(), // Afficher le modal au lieu de quitter directement
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                32.height,

                // Titre principal
                Text(
                  'Vérifions votre identité',
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                16.height,

                // Description
                Text(
                  'Nous vous demanderons une pièce d\'identité et un selfie. C\'est rapide et sécurisé, et approuvé par des millions d\'utilisateurs dans le monde entier.',
                  style: AppTextStyles.body1.copyWith(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),

                40.height, // Réduit de 64 à 40

                // Illustration
                Center(
                  child: Container(
                    width: 240, // Réduit de 280 à 240
                    height: 240, // Réduit de 280 à 240
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F8F6), // Couleur de fond turquoise clair
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Personnage
                        Container(
                          width: 180, // Réduit de 200 à 180
                          height: 180, // Réduit de 200 à 180
                          child: CustomPaint(
                            painter: PersonWithDocumentPainter(),
                          ),
                        ),

                        // Badge de vérification
                        Positioned(
                          right: 30, // Ajusté
                          top: 50, // Ajusté
                          child: Container(
                            width: 40, // Réduit de 50 à 40
                            height: 40, // Réduit de 50 à 40
                            decoration: BoxDecoration(
                              color: Color(0xFF00D4B8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24, // Réduit de 28 à 24
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                40.height, // Remplace Spacer() par un espacement fixe

                // Message de confidentialité
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Le son et la vidéo de votre session pourront être enregistrés. Lisez notre',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      4.height,
                      GestureDetector(
                        onTap: () {
                          // Action pour ouvrir l'avis de confidentialité
                          print('Ouvrir avis de confidentialité');
                        },
                        child: Text(
                          'Avis de confidentialité',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1B77B2),
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      4.height,
                      Text(
                        'pour en savoir plus sur le traitement de vos données personnelles et l\'utilisation des cookies.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Espace pour le bottomNavigationBar
              ],
            ),
          ),
        ),

        // Bottom Button
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: AppButton(
              height: 56,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              onTap: () {
                context.pushNamed(AppRoutes.identityScanScreen);
                print('Démarrer la vérification d\'identité');

              },
              elevation: 0.0,
              color: AppColors.primary, // Couleur du bouton
              child: Text(
                'C\'est parti !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter pour dessiner le personnage avec le document
class PersonWithDocumentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Corps (t-shirt blanc)
    paint.color = Colors.white;
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, centerY + 30),
        width: 80,
        height: 90,
      ),
      Radius.circular(20),
    );
    canvas.drawRRect(bodyRect, paint);

    // Contour du corps
    paint
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(bodyRect, paint);

    // Tête
    paint
      ..color = Color(0xFFFFDBAE) // Couleur de peau
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX, centerY - 30),
      25,
      paint,
    );

    // Cheveux
    paint.color = Color(0xFF4A4A4A);
    final hairPath = Path();
    hairPath.addArc(
      Rect.fromCircle(center: Offset(centerX, centerY - 30), radius: 25),
      -3.14, // -π
      3.14, // π
    );
    canvas.drawPath(hairPath, paint);

    // Yeux
    paint.color = Colors.black;
    canvas.drawCircle(Offset(centerX - 8, centerY - 35), 2, paint);
    canvas.drawCircle(Offset(centerX + 8, centerY - 35), 2, paint);

    // Sourire
    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY - 25),
        width: 16,
        height: 10,
      ),
      0,
      3.14,
    );
    canvas.drawPath(smilePath, paint);

    // Bras gauche tenant le document
    paint
      ..color = Color(0xFFFFDBAE)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - 50, centerY), 12, paint);

    // Document/téléphone dans la main
    paint.color = Color(0xFF2C2C2C);
    final docRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX - 65, centerY - 15),
        width: 20,
        height: 30,
      ),
      Radius.circular(4),
    );
    canvas.drawRRect(docRect, paint);

    // Écran du document
    paint.color = Color(0xFF4A90E2);
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX - 65, centerY - 15),
        width: 16,
        height: 26,
      ),
      Radius.circular(2),
    );
    canvas.drawRRect(screenRect, paint);

    // Bras droit
    paint.color = Color(0xFFFFDBAE);
    canvas.drawCircle(Offset(centerX + 35, centerY + 10), 12, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}