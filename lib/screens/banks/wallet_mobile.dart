import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class WalletMobile extends StatefulWidget {
  const WalletMobile({Key? key}) : super(key: key);

  @override
  State<WalletMobile> createState() => _WalletMobileState();
}

class _WalletMobileState extends State<WalletMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wallet Mobile Money',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Contenu scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Section des cartes principales
                  Row(
                    children: [
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.people_outline,
                          iconColor: AppColors.secondary,
                          iconBackground: AppColors.secondary.withOpacity(0.1),
                          title: 'Mes\nbénéficiaires',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.swap_vert,
                          iconColor: AppColors.primary,
                          iconBackground: AppColors.primary.withOpacity(0.1),
                          title: 'Mes\ntransferts',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Carte "Lier mes comptes"
                  Container(
                    width: double.infinity,
                    child: _buildServiceCard(
                      icon: Icons.link,
                      iconColor: AppColors.primary,
                      iconBackground: AppColors.primary.withOpacity(0.1),
                      title: 'Lier mes comptes',
                      isFullWidth: true,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Section des transactions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Transaction item
                        Row(
                          children: [
                            // Date
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '27-07',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Transaction details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '500 XOF',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '800XXXXXXXX1',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'MTN |',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'test',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Status
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                'Échec',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
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
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 200,
                    child: AppButton(
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                      onTap: () {
                        _showTransferModal(context);
                      },
                      elevation: 2.0,
                      color: AppColors.primary,
                      child: const Text(
                        'Envoyer de l\'argent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTransferModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Quel transfert ?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 40),

              // Transfer options
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Banque vers mobile
                      _buildTransferOption(
                        icon: Icons.account_balance_wallet,
                        iconColor: AppColors.primary,
                        title: 'Banque vers mobile',
                        subtitle: 'De la banque au portefeuille mobile',
                        onTap: () {
                          Navigator.pop(context);
                          context.pushNamed(AppRoutes.operationRetraitCompteScreen);
                          // Action pour banque vers mobile
                        },
                      ),

                      const SizedBox(height: 20),

                      // Mobile vers banque
                      _buildTransferOption(
                        icon: Icons.account_balance_wallet,
                        iconColor: AppColors.primary,
                        title: 'Mobile vers banque',
                        subtitle: 'Du portefeuille mobile à la banque',
                        onTap: () {
                          Navigator.pop(context);
                          context.pushNamed(AppRoutes.operationRetraitCompteScreen);
                          // Action pour mobile vers banque
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransferOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    bool isFullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}