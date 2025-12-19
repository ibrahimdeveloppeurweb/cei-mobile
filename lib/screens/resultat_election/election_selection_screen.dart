import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ElectionSelectionScreen extends StatefulWidget {
  const ElectionSelectionScreen({super.key});

  @override
  State<ElectionSelectionScreen> createState() => _ElectionSelectionScreenState();
}

class _ElectionSelectionScreenState extends State<ElectionSelectionScreen> {
  bool _isLoading = true;
  List<ElectionItem> _elections = [];
  String? _selectedType;
  late DateFormat _dateFormat;

  final List<String> _electionTypes = [
    'Toutes',
    'Présidentielle',
    'Législative',
    'Municipale',
    'Régionale',
    'Sénatoriale'
  ];

  @override
  void initState() {
    super.initState();
    _selectedType = _electionTypes[0]; // Default to 'Toutes'
    _initializeLocaleData();
  }

  Future<void> _initializeLocaleData() async {
    // Initialize date formatting for French locale
    await initializeDateFormatting('fr_FR', null);
    _dateFormat = DateFormat('dd MMMM yyyy', 'fr_FR');
    _loadElections();
  }

  Future<void> _loadElections() async {
    setState(() => _isLoading = true);

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock data - in a real app, this would come from an API
      // Only include completed elections with results
      _elections = [
        ElectionItem(
          type: 'Présidentielle',
          date: DateTime(2020, 10, 31),
          description: 'Élection présidentielle',
          status: ElectionStatus.completed,
          turnout: 91.66,
          hasResults: true,
        ),
        ElectionItem(
          type: 'Législative',
          date: DateTime(2021, 3, 6),
          description: 'Élection des députés',
          status: ElectionStatus.completed,
          turnout: 83.72,
          hasResults: true,
        ),
        ElectionItem(
          type: 'Municipale',
          date: DateTime(2023, 9, 2),
          description: 'Élection des maires',
          status: ElectionStatus.completed,
          turnout: 76.31,
          hasResults: true,
        ),
        ElectionItem(
          type: 'Régionale',
          date: DateTime(2023, 9, 2),
          description: 'Élection des conseils régionaux',
          status: ElectionStatus.completed,
          turnout: 74.85,
          hasResults: true,
        ),
        ElectionItem(
          type: 'Sénatoriale',
          date: DateTime(2023, 4, 16),
          description: 'Élection des sénateurs',
          status: ElectionStatus.completed,
          turnout: 81.23,
          hasResults: true,
        ),
      ];

    } catch (e) {
      toast('Erreur lors du chargement des élections: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  List<ElectionItem> get _filteredElections {
    // Filter to only show completed elections with results
    final completedElections = _elections.where(
            (election) => election.status == ElectionStatus.completed && election.hasResults
    ).toList();

    // Then apply type filter if needed
    if (_selectedType == 'Toutes') {
      return completedElections;
    }
    return completedElections.where((election) => election.type == _selectedType).toList();
  }

  Widget _buildElectionCard(ElectionItem election) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to results screen
          if (election.type == 'Présidentielle') {
            context.pushNamed(AppRoutes.electionResults, extra: election);
          }else  {
            context.pushNamed(AppRoutes.otherElectionResults, extra: election);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          election.type,
                          style: AppTextStyles.h4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        4.height,
                        Text(
                          election.description,
                          style: AppTextStyles.body2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Terminée",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      8.width,
                      Text(
                        _dateFormat.format(election.date),
                        style: AppTextStyles.body2,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people_outline,
                        size: 16,
                        color: Colors.grey,
                      ),
                      8.width,
                      Text(
                        'Participation: ${election.turnout}%',
                        style: AppTextStyles.body2,
                      ),
                    ],
                  ),
                ],
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.poll_outlined),
                    label: const Text('Voir résultats'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (election.type == 'Présidentielle') {
                        context.pushNamed(AppRoutes.electionResults, extra: election);
                      }else  {
                        context.pushNamed(AppRoutes.otherElectionResults, extra: election);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_filteredElections.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_busy, size: 64, color: Colors.grey),
            16.height,
            Text(
              "Aucune élection trouvée",
              style: AppTextStyles.h3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            8.height,
            Text(
              "Il n'y a pas d'élections terminées correspondant à votre sélection.",
              style: AppTextStyles.body1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredElections.length,
      itemBuilder: (context, index) {
        return _buildElectionCard(_filteredElections[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Résultats d'élection"),
          elevation: 0,
        ),
        body: Column(
          children: [
            // Filter bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Text(
                    "Type d'élection: ",
                    style: AppTextStyles.body2,
                  ),
                  12.width,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedType,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: _electionTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedType = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Elections list
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Election model
class ElectionItem {
  final String type;
  final DateTime date;
  final String description;
  final ElectionStatus status;
  final double turnout;
  final bool hasResults;

  ElectionItem({
    required this.type,
    required this.date,
    required this.description,
    required this.status,
    required this.turnout,
    required this.hasResults,
  });
}

enum ElectionStatus {
  upcoming,
  ongoing,
  completed,
}