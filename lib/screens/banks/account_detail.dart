import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  bool _isBalanceVisible = false;
  int _selectedTabIndex = 0;
  bool _showAllBankTransactions = false;
  bool _showAllMobileTransactions = false;

  // Données des transactions bancaires
  final List<Map<String, dynamic>> _bankTransactions = [
    {
      'type': 'Virement reçu',
      'amount': '+125,000',
      'date': '05-08',
      'fullDate': '05 Août 2025',
      'description': 'Salaire - Entreprise ABC',
      'account': '800XXXXXXXX1',
      'provider': 'CBAO',
      'status': 'Succès',
      'statusColor': Colors.green,
    },
    {
      'type': 'Prélèvement',
      'amount': '-25,500',
      'date': '04-08',
      'fullDate': '04 Août 2025',
      'description': 'Facture électricité - SENELEC',
      'account': '800XXXXXXXX2',
      'provider': 'SENELEC',
      'status': 'Échec',
      'statusColor': Colors.red,
    },
    {
      'type': 'Virement émis',
      'amount': '-50,000',
      'date': '03-08',
      'fullDate': '03 Août 2025',
      'description': 'Vers compte épargne',
      'account': '800XXXXXXXX3',
      'provider': 'CBAO',
      'status': 'En attente',
      'statusColor': Colors.orange,
    },
  ];

  // Données des transactions mobile money
  final List<Map<String, dynamic>> _mobileTransactions = [
    {
      'type': 'Dépôt Mobile',
      'amount': '+85,000',
      'date': '05-08',
      'fullDate': '05 Août 2025',
      'description': 'Dépôt Orange Money',
      'account': '771XXXXXXXX8',
      'provider': 'Orange',
      'status': 'Succès',
      'statusColor': Colors.green,
    },
    {
      'type': 'Transfert émis',
      'amount': '-12,500',
      'date': '04-08',
      'fullDate': '04 Août 2025',
      'description': 'Vers Aminata Diallo',
      'account': '776XXXXXXXX2',
      'provider': 'MTN',
      'status': 'Échec',
      'statusColor': Colors.red,
    },
    {
      'type': 'Paiement marchand',
      'amount': '-8,750',
      'date': '03-08',
      'fullDate': '03 Août 2025',
      'description': 'Supermarché Auchan',
      'account': '775XXXXXXXX5',
      'provider': 'Wave',
      'status': 'En attente',
      'statusColor': Colors.orange,
    },
  ];

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
          'Compte ****001',
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
            const SizedBox(height: 16),

            // Carte du compte
            Container(
              width: double.infinity,
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
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Icon(
                          Icons.account_balance,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Compte epargne',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              '800702157001',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Actif',
                          style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'IBRAHIM CISSE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Text(
                        _isBalanceVisible ? '1,247,350 XOF' : '*** XOF',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                        },
                        child: Icon(
                          _isBalanceVisible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'En opération depuis : Oct. 2024',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.download,
                    iconColor: AppColors.secondary,
                    iconBackground: AppColors.secondary.withOpacity(0.1),
                    title: 'Télécharger\nmon RIB',
                    onTap: () {
                      // Action téléchargement RIB
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    icon: Icons.print,
                    iconColor: AppColors.primary,
                    iconBackground: AppColors.primary.withOpacity(0.1),
                    title: 'Imprimer un\nrelevé',
                    onTap: () {
                      // Action impression relevé
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Section transactions
            const Text(
              'Transactions récentes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // Onglets
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedTabIndex == 0 ? AppColors.primary : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: _selectedTabIndex == 0 ? AppColors.primary.withOpacity(0.1) : Colors.white,
                      ),
                      child: Text(
                        'Compte bancaire',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: _selectedTabIndex == 0 ? FontWeight.w600 : FontWeight.w500,
                          color: _selectedTabIndex == 0 ? AppColors.primary : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedTabIndex == 1 ? AppColors.primary : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: _selectedTabIndex == 1 ? AppColors.primary.withOpacity(0.1) : Colors.white,
                      ),
                      child: Text(
                        'Mobile Money',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: _selectedTabIndex == 1 ? FontWeight.w600 : FontWeight.w500,
                          color: _selectedTabIndex == 1 ? AppColors.primary : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Liste des transactions
            ..._buildTransactionsList(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTransactionsList() {
    final transactions = _selectedTabIndex == 0 ? _bankTransactions : _mobileTransactions;
    final showAll = _selectedTabIndex == 0 ? _showAllBankTransactions : _showAllMobileTransactions;

    // Limite à 3 transactions si "Voir plus" n'est pas activé
    final displayedTransactions = showAll ? transactions : transactions.take(3).toList();

    List<Widget> widgets = displayedTransactions.map((transaction) => _buildTransactionItem(
      type: transaction['type'],
      amount: transaction['amount'],
      date: transaction['date'],
      description: transaction['description'],
      account: transaction['account'],
      provider: transaction['provider'],
      status: transaction['status'],
      statusColor: transaction['statusColor'],
    )).toList();

    // Ajouter le bouton "Voir plus" s'il y a plus de 3 transactions et qu'elles ne sont pas toutes affichées
    if (transactions.length > 3 && !showAll) {
      widgets.add(
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              setState(() {
                if (_selectedTabIndex == 0) {
                  _showAllBankTransactions = true;
                } else {
                  _showAllMobileTransactions = true;
                }
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Voir plus (${transactions.length - 3} restantes)',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.expand_more,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Ajouter le bouton "Voir moins" si toutes les transactions sont affichées et qu'il y en a plus de 3
    if (transactions.length > 3 && showAll) {
      widgets.add(
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              setState(() {
                if (_selectedTabIndex == 0) {
                  _showAllBankTransactions = false;
                } else {
                  _showAllMobileTransactions = false;
                }
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.withOpacity(0.3)),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Voir moins',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.expand_less,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildTransactionItem({
    required String type,
    required String amount,
    required String date,
    required String description,
    required String account,
    required String provider,
    required String status,
    required Color statusColor,
  }) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(AppRoutes.transactionDetailScreen);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
        child: Row(
          children: [
            // Date
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                date,
                style: const TextStyle(
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
                  Text(
                    '$amount XOF',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: amount.startsWith('+') ? Colors.green : (amount.startsWith('-') ? Colors.red : AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    account,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$provider |',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}