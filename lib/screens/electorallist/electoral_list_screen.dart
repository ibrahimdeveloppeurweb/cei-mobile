import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/model/demande_acces_liste_model.dart';
import 'package:cei_mobile/repository/electoral_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ElectoralListScreen extends StatefulWidget {
  const ElectoralListScreen({super.key});

  @override
  State<ElectoralListScreen> createState() => _ElectoralListScreenState();
}

class _ElectoralListScreenState extends State<ElectoralListScreen> {
  // Pour gérer les différentes vues
  bool _isLoading = false;

  // Liste des demandes - CHANGED TO USE DemandeAccesListe
  List<DemandeAccesListe> _requests = [];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  // Chargement des demandes existantes - UPDATED TO USE API
  Future<void> _loadRequests() async {
    setState(() => _isLoading = true);

    getElectoralListRequestApi().then((response) {
      setState(() => _isLoading = false);
      setState(() {
        if (response['demandes'] is List) {
          for (var data in response['demandes']) {
            _requests.add(DemandeAccesListe.fromJson(data));
          }
          setState(() {
          });
        } else {
          _requests = [];
        }
      });
    }).catchError((error) {
      setState(() => _isLoading = false);
      setState(() => _requests = []);
      toast('Erreur lors du chargement des demandes: $error', print: true);
    });
  }

  void _navigateToForm() async {
    final result = await context.pushNamed(AppRoutes.electoralForm);

    // Si une nouvelle demande a été créée, recharger la liste
    if (result != null) {
      _loadRequests();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Votre demande a été soumise avec succès."),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  // Liste des demandes
  Widget _buildRequestsList() {
    if (_requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list_alt, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Aucune demande d'accès",
              style: AppTextStyles.h4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Vous n'avez pas encore effectué de demande d'accès à la liste électorale.",
              style: AppTextStyles.body1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
              elevation: 0.0,
              color: AppColors.primary,
              onTap: _navigateToForm,
              width: context.width() * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white),
                  const SizedBox(width: 8),
                  Text('Nouvelle demande',
                      style: boldTextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mes demandes d'accès",
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle,
                    color: AppColors.primary, size: 32),
                onPressed: _navigateToForm,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(
          _requests.length,
          (index) => _buildRequestCard(_requests[index]),
        ),
      ],
    );
  }

  // Carte pour chaque demande - UPDATED TO USE DemandeAccesListe
  Widget _buildRequestCard(DemandeAccesListe request) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (request.status == DemandeStatus.enAttente) {
      statusColor = Colors.orange;
      statusIcon = Icons.pending_outlined;
      statusText = "En attente";
    } else if (request.status == DemandeStatus.approuvee) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
      statusText = "Approuvée";
    } else if (request.status == DemandeStatus.rejetee) {
      statusColor = Colors.red;
      statusIcon = Icons.cancel_outlined;
      statusText = "Refusée";
    } else {
      statusColor = Colors.grey;
      statusIcon = Icons.help_outline;
      statusText = "Inconnue";
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Afficher les détails de la demande
          _showRequestDetails(request);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Demande #${request.id}',
                      style: AppTextStyles.h4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: statusColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, color: statusColor, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${request.createdAt?.day}/${request.createdAt?.month}/${request.createdAt?.year}' ??
                    'Non spécifiée',
                style: AppTextStyles.body2,
              ),
              const SizedBox(height: 4),
              Text(
                'Commune: ${request.communeName ?? "Non spécifiée"}',
                style: AppTextStyles.body2,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Type: ${_getTypeListText(request.typeList)} (${_getTypeAccesText(request.typeAcces)})',
                style: AppTextStyles.body2,
              ),
              const SizedBox(height: 8),
              Text(
                'Motif: ${request.motif}',
                style: AppTextStyles.body2.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (request.status == DemandeStatus.approuvee)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: AppButton(
                    shapeBorder:
                        RoundedRectangleBorder(borderRadius: radius(5)),
                    elevation: 0.0,
                    color: AppColors.primary,
                    onTap: () {
                      // Ouvrir la liste électorale
                      toast('Fonctionnalité à implémenter');
                    },
                    width: context.width(),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.visibility,
                            color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text('Consulter la liste',
                            style:
                                boldTextStyle(color: Colors.white, size: 14)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Afficher les détails d'une demande - UPDATED TO USE DemandeAccesListe
  void _showRequestDetails(DemandeAccesListe request) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Détails de la demande',
                      style: AppTextStyles.h3,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildStatusIndicator(request),
                const SizedBox(height: 24),
                const Text(
                  'Informations de la demande',
                  style: AppTextStyles.h4,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                    'Date de soumission',
                    '${request.createdAt?.day}/${request.createdAt?.month}/${request.createdAt?.year}' ??
                        'Non spécifiée'),
                _buildInfoRow('Motif', request.motif),
                _buildInfoRow('Année', request.anneeName),
                if (request.districtName != null)
                  _buildInfoRow('District', request.districtName!),
                if (request.regionName != null)
                  _buildInfoRow('Région', request.regionName!),
                if (request.departementName != null)
                  _buildInfoRow('Département', request.departementName!),
                if (request.sousPrefectureName != null)
                  _buildInfoRow('Sous-préfecture', request.sousPrefectureName!),
                if (request.communeName != null)
                  _buildInfoRow('Commune', request.communeName!),
                _buildInfoRow(
                    'Type de liste', _getTypeListText(request.typeList)),
                _buildInfoRow(
                    'Type d\'accès', _getTypeAccesText(request.typeAcces)),
                if (request.status == DemandeStatus.rejetee &&
                    request.commentaireValidation != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Text(
                        'Motif du refus',
                        style: AppTextStyles.h4,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.red.withOpacity(0.3)),
                        ),
                        child: Text(
                          request.commentaireValidation!,
                          style: AppTextStyles.body2,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 24),
                if (request.status == DemandeStatus.approuvee)
                  AppButton(
                    shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                    elevation: 0.0,
                    color: AppColors.primary,
                    onTap: () async{
                      await launchUrl(Uri.parse('https://cei.prodestic.fr.fo/admin/enrolements/index/non-traite'), mode: LaunchMode.externalApplication);
                    },
                    width: context.width(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.description, color: Colors.white),
                        const SizedBox(width: 8),
                        Text('Consulter la liste électorale',
                            style: boldTextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                if (request.status == DemandeStatus.rejetee)
                  AppButton(
                    shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                    elevation: 0.0,
                    color: AppColors.primary,
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToForm();
                    },
                    width: context.width(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.refresh, color: Colors.white),
                        const SizedBox(width: 8),
                        Text('Soumettre une nouvelle demande',
                            style: boldTextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Indicateur de statut pour la modal - UPDATED TO USE DemandeAccesListe
  Widget _buildStatusIndicator(DemandeAccesListe request) {
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusDescription;

    if (request.status == DemandeStatus.enAttente) {
      statusColor = Colors.orange;
      statusIcon = Icons.pending_outlined;
      statusText = "Demande en attente";
      statusDescription =
          "Votre demande est en cours d'examen. Vous recevrez une notification dès qu'elle sera traitée.";
    } else if (request.status == DemandeStatus.approuvee) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_outline;
      statusText = "Demande approuvée";
      statusDescription =
          "Votre demande d'accès à la liste électorale a été approuvée.";
    } else if (request.status == DemandeStatus.rejetee) {
      statusColor = Colors.red;
      statusIcon = Icons.cancel_outlined;
      statusText = "Demande refusée";
      statusDescription =
          "Nous sommes désolés, mais votre demande d'accès à la liste électorale a été refusée.";
    } else {
      statusColor = Colors.grey;
      statusIcon = Icons.help_outline;
      statusText = "Statut inconnu";
      statusDescription =
          "Le statut de votre demande n'est pas disponible actuellement.";
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: AppTextStyles.h4.copyWith(
                    color: statusColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  statusDescription,
                  style: AppTextStyles.body2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Ligne d'informations pour les détails
  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTextStyles.body2.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value??'Non spécifiée',
              style: AppTextStyles.body2,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods to convert enums to display text
  String _getTypeListText(TypeList? typeList) {
    switch (typeList) {
      case TypeList.provisoire:
        return 'Liste provisoire';
      case TypeList.definitive:
        return 'Liste définitive';
      case null:
        return "Non spécifiée";
    }
  }

  String _getTypeAccesText(TypeAcces? typeAcces) {
    switch (typeAcces) {
      case TypeAcces.lecture:
        return 'Lecture seule';
      case TypeAcces.ecriture:
        return 'Lecture et écriture';
      case null:
         return "Non spécifiée";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Liste Électorale'),
          elevation: 0,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildRequestsList(),
                ),
              ),
        floatingActionButton: _requests.isNotEmpty
            ? FloatingActionButton(
                onPressed: _navigateToForm,
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
