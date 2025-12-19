import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BankingHomePage extends StatefulWidget {
  @override
  _BankingHomePageState createState() => _BankingHomePageState();
}

class _BankingHomePageState extends State<BankingHomePage> {
  String selectedOption = 'Compte bancaire'; // Option sélectionnée par défaut

  Widget _buildOptionButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: isSelected ? Border.all(color: Colors.grey[300]!) : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.grey[700] : Colors.grey[500],
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // En-tête personnalisé avec SafeArea
            Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                color: Color(0xFF1a237e), // Bleu marine foncé de la capture
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bonsoir,',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'IBRAHIM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 18,
                                      child: Icon(
                                        Icons.person_outline,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 18,
                                    child: Icon(
                                      Icons.notifications_outlined,
                                      color: Colors.grey[600],
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Espace pour la carte positionnée
                      ],
                    ),

                    // Carte de solde positionnée
                    Positioned(
                      top: 80, // Position après la section du haut
                      left: 16,
                      right: 16,

                      child: Container(
                        height: 200,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF283593), Color(0xFF1a237e)], // Dégradé bleu marine
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Solde total',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                Text(
                                  'XOF',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              '***',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '01 compte(s)',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 24),
                                Icon(
                                  Icons.credit_card_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '0 cartes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.height,
            // Contenu principal avec fond blanc
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Dernières transactions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dernières transactions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Voir tout',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Boutons de transaction cliquables
                    Row(
                      children: [
                        _buildOptionButton('Compte bancaire', selectedOption == 'Compte bancaire'),
                        SizedBox(width: 12),
                        _buildOptionButton('Mobile Money', selectedOption == 'Mobile Money'),
                      ],
                    ),
                    SizedBox(height: 24),

                    Text(
                      'Aucune transaction pour le moment',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 32),

                    // Section Raccourcis
                    Row(
                      children: [
                        Text(
                          'Raccourcis',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(0xFFff6f00), // Orange de la capture
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.question_mark,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Grille des raccourcis
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildShortcutCard(
                                Icons.support_agent,
                                'Service\nclient',
                                Color(0xFFff6f00).withOpacity(0.1), // Orange clair
                                Color(0xFFff6f00), // Orange
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: _buildShortcutCard(
                                Icons.phone_android,
                                'Mobile Money',
                                Color(0xFF1a237e).withOpacity(0.1), // Bleu marine clair
                                Color(0xFF1a237e), // Bleu marine
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: _buildShortcutCard(
                                Icons.download,
                                'Obtenir\nmon RIB ',
                                Color(0xFFff6f00).withOpacity(0.1), // Orange clair
                                Color(0xFFff6f00), // Orange
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: _buildShortcutCard(
                                Icons.print,
                                'Obtenir\nmon relevé ',
                                Color(0xFF1a237e).withOpacity(0.1), // Bleu marine clair
                                Color(0xFF1a237e), // Bleu marine
                              ),
                            ),
                          ],
                        ),
                      ],
                    ), // Espace en bas
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildShortcutCard(IconData icon, String title, Color backgroundColor, Color? iconColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20), // Padding réduit
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2), // Position de l'ombre
          ),
        ],
      ),
      child: Row( // Changé de Column à Row pour l'alignement horizontal
        mainAxisAlignment: MainAxisAlignment.start, // Alignement à gauche
        children: [
          Container(
            width: 32, // Taille réduite
            height: 32, // Taille réduite
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16, // Taille d'icône réduite
            ),
          ),
          SizedBox(width: 8), // Espacement horizontal réduit
          Expanded( // Pour que le texte prenne l'espace restant
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11, // Taille de police légèrement réduite
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}