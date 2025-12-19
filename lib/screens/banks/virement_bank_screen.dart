import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' show AppButton, ContextExtensions, radius;

class VirementsScreen extends StatefulWidget {
  const VirementsScreen({Key? key}) : super(key: key);

  @override
  State<VirementsScreen> createState() => _VirementsScreenState();
}

class _VirementsScreenState extends State<VirementsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Contenu principal
          Column(
            children: [
              // Header avec gradient
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                    color: Color(0xFF1a237e) // Bleu marine foncé
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mes virements',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Zone principale vide
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bouton "Nouveau virement" positionné à droite et en bas
          Positioned(
            right: 16,
            bottom: 16,
            child: SizedBox(
              width: 200, // Largeur fixe pour le bouton
              child: AppButton(
                shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                onTap: () {
                  // Votre action ici
                },
                elevation: 0.0,
                color: AppColors.primary, // Garde la couleur originale
                child: const Text(
                    'nouveau virement',
                    style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}