import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';


class AccountBankScreen extends StatefulWidget {
  @override
  _AccountBankScreenState createState() => _AccountBankScreenState();
}

class _AccountBankScreenState extends State<AccountBankScreen> {
  int _selectedIndex = 1; // Comptes est sélectionné par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.secondary, // Bleu marine foncé
        elevation: 0,
        title: Row(
          children: [
            Text(
              '*** XOF',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.visibility,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 16, bottom: 12),
            child: Text(
              'Total comptes',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: (){
                  context.pushNamed(AppRoutes.accountDetailScreen);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Compte épargne card
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primary, // Orange
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Compte épargne',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '800702157001',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1), // Orange clair
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'Actif',
                                  style: TextStyle(
                                    color: AppColors.primary, // Orange
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  
                      // Compte principal card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'IBRAHIM CISSE',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          '*** XOF',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondary, // Bleu marine
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.visibility,
                                          color: AppColors.secondary, // Bleu marine
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey[400],
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bouton Ajouter un compte
          Container(
            padding: EdgeInsets.all(16),
            child:  AppButton(
              width: context.width(),
              shapeBorder:
              RoundedRectangleBorder(borderRadius: radius()),
              onTap: () {

              },
              elevation: 0.0,
              color: AppColors.primary, // Garde la couleur originale
              child: const Text('Ajouter un nouveau compte',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}