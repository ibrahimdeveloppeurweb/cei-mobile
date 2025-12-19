import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1a237e), // Bleu marine foncé
        elevation: 0,
        title: const Text(
          'Support',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Conseil clientèle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFff6f00).withOpacity(0.1), // Orange clair
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFFff6f00), // Orange
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Conseil clientèle',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Soukpa Darouny Aureli...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CREDIT FEF AGENCE DES 2 PLA...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Mon agence',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Fermé',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Situé à : Rdc Immeuble Sayegh, rue des Jardins, 2 Plateaux',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFff6f00).withOpacity(0.1), // Orange clair
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Itinéraire',
                      style: TextStyle(
                        color: Color(0xFFff6f00), // Orange
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Boutons d'action
            Row(
              children: [
                Expanded(
                    child:
                    Container(
                      padding: EdgeInsets.all(8),
                      child:  AppButton(
                        width: context.width(),
                        shapeBorder:
                        RoundedRectangleBorder(borderRadius: radius()),
                        onTap: () {

                        },
                        elevation: 0.0,
                        color: AppColors.primary, // Garde la couleur originale
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Prendre RDV',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                const SizedBox(width: 12),
                Expanded(
                    child:
                    Container(
                      padding: EdgeInsets.all(8),
                      child:  AppButton(
                        width: context.width(),
                        shapeBorder:
                        RoundedRectangleBorder(borderRadius: radius()),
                        onTap: () {

                        },
                        elevation: 0.0,
                        color: AppColors.primary, // Garde la couleur originale
                        child:const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Ecrire',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                ),

              ],
            ),

            const SizedBox(height: 32),

            // Options de support
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Expanded(
                  child: _buildSupportOption(
                    icon: Icons.calendar_today,
                    title: 'Mes\nRendez-vous',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSupportOption(
                    icon: Icons.chat_bubble_outline,
                    title: 'Mes\nréclamations',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _buildSupportOption(
                    icon: Icons.help_outline,
                    title: 'Foire Aux\nQuestions',
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSupportOption(
                    icon: Icons.support_agent,
                    title: 'Assistance',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.1), // Bleu marine clair
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: AppColors.secondary, // Bleu marine
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? Color(0xFFff6f00) : Colors.grey, // Orange pour actif
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Color(0xFFff6f00) : Colors.grey, // Orange pour actif
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}