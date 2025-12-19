import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'candidature_init_screen.dart';

class ProfilCandidatScreen extends StatefulWidget {
  const ProfilCandidatScreen({Key? key}) : super(key: key);

  @override
  _ProfilCandidatScreenState createState() => _ProfilCandidatScreenState();
}

class _ProfilCandidatScreenState extends State<ProfilCandidatScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  // Données simulées pour un profil de candidat
  final Map<String, dynamic> _candidateProfile = {
    "nom": "Koné",
    "prenoms": "Ibrahim",
    "dateNaissance": "1975-03-18",
    "lieuNaissance": "Bouaké",
    "nationalite": "Ivoirienne",
    "profession": "Enseignant",
    "adresse": "Cocody, Abidjan",
    "email": "ibrahim.kone@gmail.com",
    "telephone": "+225 0707010203",
    "numeroElecteur": "V1234567890",
    "enroleDepuis": "2010",
    "bureauVote": "EPP Cocody Angré",
    "photo": "assets/images/profile_photo.jpg"
  };

  // Historique des candidatures (simulées)
  final List<Map<String, dynamic>> _candidatureHistory = [
    {
      "id": "CAND-2020-1234",
      "type": ElectionType.municipale,
      "date": "2020-04-15",
      "circonscription": "Commune de Cocody",
      "status": "Terminée",
      "resultat": "Élu (56% des voix)",
      "mandat": "2020-2025",
      "color": AppColors.primary,
    },
    {
      "id": "CAND-2015-5678",
      "type": ElectionType.regionale,
      "date": "2015-03-22",
      "circonscription": "Région des Lagunes",
      "status": "Terminée",
      "resultat": "Non élu (32% des voix)",
      "mandat": "-",
      "color": Colors.red,
    }
  ];

  // Candidature active (simulée)
  final Map<String, dynamic>? _activeCandidature = {
    "id": "CAND-2025-9012",
    "type": ElectionType.legislative,
    "dateDepot": "2025-02-20",
    "circonscription": "Département d'Abidjan",
    "status": "En cours de traitement",
    "progression": 0.65, // 65% de progression
    "echeance": "2025-06-30", // Date limite du processus
    "prochainEtape": "Validation par la commission électorale",
  };

  // Élections à venir auxquelles le candidat peut participer (simulées)
  final List<Map<String, dynamic>> _upcomingElections = [
    {
      "id": "ELECT-2025-001",
      "title": "Élection Présidentielle 2025",
      "date": "2025-10-31",
      "type": ElectionType.presidentielle,
      "icon": Icons.stars,
      "color": Colors.purple,
      "registrationDeadline": "2025-07-31",
      "eligibility": {
        "age": 35,
        "isEligible": true,
        "reason": null
      }
    },
    {
      "id": "ELECT-2025-002",
      "title": "Élections Sénatoriales 2025",
      "date": "2025-12-15",
      "type": ElectionType.senatoriale,
      "icon": Icons.business,
      "color": Colors.teal,
      "registrationDeadline": "2025-09-15",
      "eligibility": {
        "age": 35,
        "isEligible": true,
        "reason": null
      }
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Simuler le chargement des données
    _loadCandidateData();
  }

  Future<void> _loadCandidateData() async {
    // Simuler un chargement
    setState(() {
      _isLoading = true;
    });

    // Dans une application réelle, vous chargeriez les vraies données depuis votre API
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Espace Candidat'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.grey3,
          tabs: const [
            Tab(text: 'Profil', icon: Icon(Icons.person)),
            Tab(text: 'Candidatures', icon: Icon(Icons.how_to_vote)),
            Tab(text: 'Élections', icon: Icon(Icons.event)),
          ],
        ),
      ),
      body: _isLoading
          ? _buildLoadingView()
          : TabBarView(
        controller: _tabController,
        children: [
          _buildProfileTab(),
          _buildCandidaturesTab(),
          _buildElectionsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CandidatureInitScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle candidature'),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          SizedBox(height: 20),
          Text('Chargement de vos informations...'),
        ],
      ),
    );
  }

  // Tab 1: Profil du candidat
  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête du profil
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo de profil
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person, size: 60, color: Colors.grey),
              ),
              const SizedBox(width: 20),
              // Informations de base
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_candidateProfile["prenoms"]} ${_candidateProfile["nom"]}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _candidateProfile["profession"],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInfoChip(
                      "Électeur depuis ${_candidateProfile["enroleDepuis"]}",
                      Icons.how_to_reg,
                      Colors.green,
                    ),
                    const SizedBox(height: 4),
                    _buildInfoChip(
                      "Numéro électeur: ${_candidateProfile["numeroElecteur"]}",
                      Icons.badge,
                      AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Informations personnelles
          _buildProfileSection(
            "Informations personnelles",
            Icons.person_outline,
            [
              _buildInfoRow("Date de naissance", _formatDate(_candidateProfile["dateNaissance"])),
              _buildInfoRow("Lieu de naissance", _candidateProfile["lieuNaissance"]),
              _buildInfoRow("Nationalité", _candidateProfile["nationalite"]),
            ],
          ),
          const SizedBox(height: 20),

          // Informations de contact
          _buildProfileSection(
            "Coordonnées",
            Icons.contact_phone,
            [
              _buildInfoRow("Adresse", _candidateProfile["adresse"]),
              _buildInfoRow("Email", _candidateProfile["email"]),
              _buildInfoRow("Téléphone", _candidateProfile["telephone"]),
            ],
          ),
          const SizedBox(height: 20),

          // Informations électorales
          _buildProfileSection(
            "Informations électorales",
            Icons.how_to_vote,
            [
              _buildInfoRow("Bureau de vote", _candidateProfile["bureauVote"]),
              _buildInfoRow("Circonscription", "Commune de Cocody"),
              _buildInfoRow("Statut", _candidateProfile["profession"] == "Enseignant" ? "Fonctionnaire" : "Civil"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, IconData icon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              "$label :",
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

  // Tab 2: Candidatures passées et en cours
  Widget _buildCandidaturesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Candidature active (si elle existe)
          if (_activeCandidature != null) ...[
            const Text(
              'Candidature en cours',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildActiveCandidatureCard(_activeCandidature!),
            const SizedBox(height: 30),
          ],

          // Historique des candidatures
          const Text(
            'Historique des candidatures',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _candidatureHistory.isEmpty
              ? _buildEmptyHistoryMessage()
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _candidatureHistory.length,
            itemBuilder: (context, index) {
              return _buildHistoryCandidatureCard(_candidatureHistory[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCandidatureCard(Map<String, dynamic> candidature) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Candidature en cours',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getElectionTypeLabel(candidature["type"]),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      candidature["status"],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRowWhite("Numéro de dossier:", candidature["id"]),
          _buildInfoRowWhite("Circonscription:", candidature["circonscription"]),
          _buildInfoRowWhite("Date de dépôt:", _formatDate(candidature["dateDepot"])),
          _buildInfoRowWhite("Échéance:", _formatDate(candidature["echeance"])),

          const SizedBox(height: 20),
          const Text(
            'Progression du dossier',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: candidature["progression"],
              backgroundColor: Colors.white.withOpacity(0.3),
              color: Colors.white,
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Prochaine étape: ${candidature["prochainEtape"]}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  onTap: () {
                    // Voir les détails de la candidature
                  },
                  elevation: 0.0,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.visibility, color: AppColors.primary),
                      8.width,
                      Text('Voir les détails', style: boldTextStyle(color: AppColors.primary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  onTap: () {
                    // Action pour annuler la candidature
                    _showCancelCandidatureDialog();
                  },
                  elevation: 0.0,
                  color: Colors.red.shade700,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cancel, color: Colors.white),
                      8.width,
                      Text('Annuler', style: boldTextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRowWhite(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCandidatureCard(Map<String, dynamic> candidature) {
    final Color statusColor = candidature["color"];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                Text(
                  _getElectionTypeLabel(candidature["type"]),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                    fontSize: 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    candidature["status"],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Numéro de dossier", candidature["id"]),
                _buildInfoRow("Circonscription", candidature["circonscription"]),
                _buildInfoRow("Date de dépôt", _formatDate(candidature["date"])),
                _buildInfoRow("Résultat", candidature["resultat"]),
                _buildInfoRow("Mandat", candidature["mandat"]),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        // Voir les détails de la candidature passée
                      },
                      icon: const Icon(Icons.visibility, color: AppColors.primary, size: 16),
                      label: const Text(
                        'Voir les détails',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildEmptyHistoryMessage() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.history, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Vous n\'avez pas encore participé à des élections',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Tab 3: Élections à venir
  Widget _buildElectionsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Élections à venir',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Vous pouvez soumettre votre candidature pour les élections suivantes:',
                        style: TextStyle(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Liste des élections à venir
          _upcomingElections.isEmpty
              ? _buildNoElectionsMessage()
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _upcomingElections.length,
            itemBuilder: (context, index) {
              return _buildElectionCard(_upcomingElections[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildElectionCard(Map<String, dynamic> election) {
    final bool isEligible = election["eligibility"]["isEligible"];
    final Color color = election["color"];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEligible
              ? () {
            // Démarrer une nouvelle candidature pour cette élection
            _startNewCandidature(election);
          }
              : null,
          borderRadius: BorderRadius.circular(12),
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
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        election["icon"],
                        color: color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            election["title"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.event, size: 14, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(
                                'Date: ${_formatDate(election["date"])}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isEligible)
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          'Date limite de candidature: ${_formatDate(election["registrationDeadline"])}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Badge d'éligibilité
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isEligible ? Colors.green.shade50 : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isEligible ? Colors.green.shade200 : Colors.red.shade200,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isEligible ? Icons.check_circle : Icons.error,
                            size: 16,
                            color: isEligible ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isEligible
                                ? 'Vous êtes éligible'
                                : 'Non éligible: ${election["eligibility"]["reason"]}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isEligible ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isEligible) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: AppButton(
                          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          onTap: () {
                            // Démarrer une nouvelle candidature pour cette élection
                            _startNewCandidature(election);
                          },
                          elevation: 0.0,
                          color: color,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.how_to_vote, color: Colors.white),
                              8.width,
                              Text('Soumettre ma candidature', style: boldTextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoElectionsMessage() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.event_busy, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Aucune élection à venir pour le moment',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showNewCandidatureModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nouvelle candidature',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Choisissez une méthode pour soumettre votre candidature:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildActionCard(
                context: context,
                title: 'Candidature avec vérification d\'enrôlement',
                description: 'Processus sécurisé avec vérification de votre identité',
                icon: Icons.verified_user,
                color: Colors.green,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CandidatureInitScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                context: context,
                title: 'Candidature standard',
                description: 'Processus classique de candidature',
                icon: Icons.how_to_vote,
                color: AppColors.primary,
                onTap: () {
                  Navigator.pop(context);
                  _tabController.animateTo(2); // Aller à l'onglet des élections
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  void _startNewCandidature(Map<String, dynamic> election) {
    // Configurer le store avec le type d'élection
    candidatureStore.setElectionType(election["type"]);
    candidatureStore.resetCandidature();
    candidatureStore.goToStep(0);

    // Naviguer vers l'écran de candidature
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const CandidatureFormScreen(),
    //   ),
    // );
  }

  void _showCancelCandidatureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer l\'annulation'),
          content: const Text(
            'Êtes-vous sûr de vouloir annuler votre candidature ? Cette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Non, conserver'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Afficher un indicateur de progression
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Annulation de votre candidature...'),
                    duration: Duration(seconds: 1),
                  ),
                );

                // Simuler l'annulation
                await Future.delayed(const Duration(seconds: 1));

                setState(() {
                  // Mettre à jour l'état local
                  // _activeCandidature = null;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Votre candidature a été annulée'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Oui, annuler'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _getElectionTypeLabel(ElectionType? type) {
    switch (type) {
      case ElectionType.presidentielle:
        return 'Élection Présidentielle';
      case ElectionType.legislative:
        return 'Élection Législative';
      case ElectionType.senatoriale:
        return 'Élection Sénatoriale';
      case ElectionType.regionale:
        return 'Élection Régionale';
      case ElectionType.municipale:
        return 'Élection Municipale';
      default:
        return 'Non spécifié';
    }
  }
}