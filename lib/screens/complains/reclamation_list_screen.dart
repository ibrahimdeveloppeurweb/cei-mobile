import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReclamationListScreen extends StatefulWidget {
  const ReclamationListScreen({super.key});

  @override
  State<ReclamationListScreen> createState() => _ReclamationListScreenState();
}

class _ReclamationListScreenState extends State<ReclamationListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  final List<Map<String, dynamic>> _reclamations = [];

  // Filter related variables
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filterType = 'Tous'; // 'Tous', 'Inscription', 'Radiation', 'Correction'
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchReclamations();
  }

  Future<void> _fetchReclamations() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock data for demonstration
    setState(() {
      _reclamations.addAll([
        {
          'id': 'REC-25481-2025',
          'type': 'Inscription',
          'date': '12/04/2025 10:05',
          'status': 'En cours',
          'concernedPerson': 'Kouassi François',
          'justification': 'Personne omise de la liste électorale lors de la révision.',
          'center': 'EPP Gnousso de Gagnoa',
        },
        {
          'id': 'REC-13742-2025',
          'type': 'Radiation',
          'date': '05/03/2025 16:00',
          'status': 'Traitée',
          'concernedPerson': 'Konan Laurent',
          'justification': 'Personne décédée en janvier 2025.',
          'center': 'EPP Gnousso de Gagnoa',
        },
        {
          'id': 'REC-98742-2025',
          'type': 'Correction',
          'date': '28/02/2025 11:21',
          'status': 'Rejetée',
          'concernedPerson': 'Koffi Aristide',
          'justification': 'Erreur dans l\'orthographe du nom de famille.',
          'center': 'EPP Gnousso de Gagnoa',
        },
        {
          'id': 'REC-48621-2025',
          'type': 'Inscription',
          'date': '15/01/2025 18:41',
          'status': 'Traitée',
          'concernedPerson': 'Bamba Souleymane',
          'justification': 'Nouvel arrivant dans la circonscription.',
          'center': 'EPP Gnousso de Gagnoa',
        },
      ]);
      _isLoading = false;
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En cours':
        return Colors.blue;
      case 'Traitée':
        return Colors.green;
      case 'Rejetée':
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredReclamations() {
    // First apply tab filter
    List<Map<String, dynamic>> result;
    switch (_tabController.index) {
      case 0: // Toutes
        result = _reclamations;
        break;
      case 1: // En cours
        result = _reclamations.where((r) => r['status'] == 'En cours').toList();
        break;
      case 2: // Traitées
        result = _reclamations.where((r) => r['status'] == 'Traitée' || r['status'] == 'Rejetée').toList();
        break;
      default:
        result = _reclamations;
    }

    // Then apply the search filter
    if (_searchQuery.isNotEmpty) {
      result = result.where((r) {
        return r['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            r['concernedPerson'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            r['justification'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Apply type filter
    if (_filterType != 'Tous') {
      result = result.where((r) => r['type'] == _filterType).toList();
    }

    return result;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_outlined,
            size: 64,
            color: AppColors.grey2,
          ),
          const SizedBox(height: 16),
          const Text(
            'Aucune réclamation trouvée',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty || _filterType != 'Tous'
                ? 'Aucun résultat correspondant à vos critères de recherche'
                : 'Vous n\'avez pas encore soumis de réclamation',
            style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isNotEmpty || _filterType != 'Tous')
            AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
              elevation: 0.0,
              color: AppColors.grey2,
              onTap: () {
                setState(() {
                  _searchQuery = '';
                  _searchController.clear();
                  _filterType = 'Tous';
                });
              },
              child: Text('Effacer les filtres', style: boldTextStyle(color: Colors.white)),
            )
          else
            AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
              elevation: 0.0,
              color: AppColors.primary,
              onTap: () {
                context.pushNamed(AppRoutes.reclamation);
              },
              child: Text('Soumettre une réclamation', style: boldTextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }

  Widget _buildReclamationCard(Map<String, dynamic> reclamation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey2.withOpacity(0.5)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          children: [
            Expanded(
              child: Text(
                reclamation['id'],
                style: AppTextStyles.body1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(reclamation['status']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                reclamation['status'],
                style: AppTextStyles.caption.copyWith(
                  color: _getStatusColor(reclamation['status']),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    reclamation['type'],
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Le ${reclamation['date']}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Electeur: ${reclamation['concernedPerson']}',
              style: AppTextStyles.body2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onTap: () {
          context.pushNamed(
            AppRoutes.reclamationDetails,
            extra: reclamation,
          );
        },
      ),
    );
  }

  Widget _buildFilterChip(String label, String filterValue) {
    return FilterChip(
      label: Text(label),
      selectedColor: AppColors.primary.withOpacity(0.2),
      labelStyle: AppTextStyles.caption.copyWith(
        color: _filterType == filterValue ? AppColors.primary : AppColors.textPrimary,
        fontWeight: _filterType == filterValue ? FontWeight.bold : FontWeight.normal,
      ),
      selected: _filterType == filterValue,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _filterType == filterValue ? AppColors.primary : AppColors.grey2,
        ),
      ),
      onSelected: (bool selected) {
        setState(() {
          _filterType = selected ? filterValue : 'Tous';
        });
      },
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Rechercher une réclamation...',
            prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_searchQuery.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  ),
                IconButton(
                  icon: Icon(
                    _showFilters ? Icons.filter_list_off : Icons.filter_list,
                    color: _filterType != 'Tous' ? AppColors.primary : AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _showFilters = !_showFilters;
                    });
                  },
                ),
              ],
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.grey2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        if (_showFilters) ...[
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 4),
                _buildFilterChip('Tous', 'Tous'),
                const SizedBox(width: 8),
                _buildFilterChip('Inscription', 'Inscription'),
                const SizedBox(width: 8),
                _buildFilterChip('Radiation', 'Radiation'),
                const SizedBox(width: 8),
                _buildFilterChip('Correction', 'Correction'),
              ],
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredReclamations = _getFilteredReclamations();

    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: context.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          elevation: 0,
          title: Text(
            'Mes Réclamations',
            style: AppTextStyles.h2.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(FluentIcons.question_circle_20_regular, color: Colors.white),
              onPressed: () {
                showArticleInfo(context);
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Toutes'),
              Tab(text: 'En cours'),
              Tab(text: 'Traitées'),
            ],
            onTap: (_) {
              setState(() {});
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchAndFilter(),
              const SizedBox(height: 16),
              Expanded(
                child: Skeletonizer(
                  enabled: _isLoading,
                  child: filteredReclamations.isEmpty && !_isLoading
                      ? _buildEmptyState()
                      : ListView.builder(
                    itemCount: _isLoading ? 4 : filteredReclamations.length,
                    itemBuilder: (context, index) {
                      if (_isLoading) {
                        // Skeleton loader
                        return _buildReclamationCard({
                          'id': 'REC-12345-2025',
                          'type': 'Inscription',
                          'date': '01/01/2025',
                          'status': 'En cours',
                          'concernedPerson': 'Nom Prénom',
                          'justification': 'Justification de la réclamation',
                          'center': 'EPP Gnousso de Gagnoa',
                        });
                      }
                      return _buildReclamationCard(filteredReclamations[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  text:  'Faire une réclamation',
                  elevation: 0,
                  color: AppColors.primary,
                  textColor: Colors.white,
                  onTap: () {
                    context.pushNamed(AppRoutes.reclamation);
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}