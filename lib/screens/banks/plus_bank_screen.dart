import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddInfosScreen extends StatefulWidget {
  const AddInfosScreen({Key? key}) : super(key: key);

  @override
  State<AddInfosScreen> createState() => _AddInfosScreenState();
}

class _AddInfosScreenState extends State<AddInfosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1a237e), // Bleu marine foncé
        elevation: 0,
        title: const Text(
          'Plus',
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
            // Section Autres services
            const Text(
              'Autres services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            _buildMenuItem(
              icon: Icons.account_balance_wallet,
              iconColor: AppColors.primary, // Orange
              title: 'Wallet Mobile Money',
              onTap: () {
                context.pushNamed(AppRoutes.walletScreen);
              },
            ),

            _buildMenuItem(
              icon: Icons.account_balance,
              iconColor: AppColors.primary, // Orange
              title: 'Agences ',
              onTap: () {},
            ),



            const SizedBox(height: 32),

            // Section Paramètres
            const Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),

            _buildMenuItem(
              icon: Icons.person,
              iconColor: AppColors.secondary, // Bleu marine
              title: 'Mon profil',
              onTap: () {},
            ),

            _buildMenuItem(
              icon: Icons.notifications,
              iconColor: AppColors.secondary, // Bleu marine
              title: 'Mes notifications',
              onTap: () {},
            ),

            _buildMenuItem(
              icon: Icons.language,
              iconColor: AppColors.secondary, // Bleu marine
              title: 'Langue',
              onTap: () {},
            ),

            _buildMenuItem(
              icon: Icons.share,
              iconColor: AppColors.secondary, // Bleu marine
              title: 'Partager l\'application',
              onTap: () {},
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // decoration: BoxDecoration(
        //   color: Colors.grey[50],
        //   borderRadius: BorderRadius.circular(12),
        // ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDisabled ? Colors.grey : Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDisabled ? Colors.grey : Colors.grey[600],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}