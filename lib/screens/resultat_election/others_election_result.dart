import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'election_selection_screen.dart';

class OthersElectionResultsScreen extends StatefulWidget {
  final ElectionItem election;

  const OthersElectionResultsScreen({
    Key? key,
    required this.election,
  }) : super(key: key);

  @override
  State<OthersElectionResultsScreen> createState() => _OthersElectionResultsScreenState();
}

class _OthersElectionResultsScreenState extends State<OthersElectionResultsScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  Map<String, List<PartyResult>> _departmentResults = {};
  List<PartyResult> _nationalResults = [];
  List<String> _departments = [];
  TabController? _tabController;
  late DateFormat _dateFormat;

  // Colors for the different parties
  final Map<String, Color> _partyColors = {
    'RHDP': const Color(0xFFD68B46), // Orange-brown
    'PDCI': const Color(0xFF5FC3B5), // Teal
    'FPI': const Color(0xFF5BA17F),  // Green
  };

  @override
  void initState() {
    super.initState();
    _initializeLocaleData();
  }

  Future<void> _initializeLocaleData() async {
    _dateFormat = DateFormat('dd MMMM yyyy', 'fr_FR');
    _loadResults();
  }

  Future<void> _loadResults() async {
    setState(() => _isLoading = true);

    try {
      // Simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock data for national results
      _nationalResults = [
        PartyResult(party: 'RHDP', votes: 5130000, seats: 1234, candidates: 1234, electedCandidates: 22),
        PartyResult(party: 'PDCI', votes: 4850000, seats: 1234, candidates: 1234, electedCandidates: 22),
        PartyResult(party: 'FPI', votes: 4870000, seats: 1234, candidates: 1234, electedCandidates: 22),
      ];

      // Mock department data
      _departments = [
        'National',
        'Abidjan',
        'Bouaké',
        'Daloa',
        'Korhogo',
        'Man',
        'San-Pédro',
        'Yamoussoukro',
      ];

      // Generate mock results for each department
      for (final department in _departments) {
        if (department == 'National') continue; // Skip national as it's handled separately

        // Generate random but plausible results for each department
        _departmentResults[department] = [
          PartyResult(
            party: 'RHDP',
            votes: 300000 + (200000 * department.length % 5),
            seats: 150 + (department.length % 5) * 10,
            candidates: 150 + (department.length % 3) * 10,
            electedCandidates: 5 + (department.length % 3),
          ),
          PartyResult(
            party: 'PDCI',
            votes: 280000 + (180000 * department.length % 7),
            seats: 150 + (department.length % 6) * 10,
            candidates: 150 + (department.length % 4) * 10,
            electedCandidates: 4 + (department.length % 4),
          ),
          PartyResult(
            party: 'FPI',
            votes: 290000 + (190000 * department.length % 6),
            seats: 150 + (department.length % 7) * 10,
            candidates: 150 + (department.length % 5) * 10,
            electedCandidates: 3 + (department.length % 5),
          ),
        ];
      }

      // Initialize tab controller after data is loaded
      _tabController = TabController(
        length: _departments.length,
        vsync: this,
      );

    } catch (e) {
      toast('Erreur lors du chargement des résultats: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text("Chargement des résultats..."),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.election.type,
                      style: AppTextStyles.h3.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.election.description,
                      style: AppTextStyles.body1,
                      maxLines: 2,
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
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    _dateFormat.format(widget.election.date),
                    style: AppTextStyles.body2,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    'Participation: ${widget.election.turnout}%',
                    style: AppTextStyles.body2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<PartyResult> results) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Score obtenu par groupement/parti politique",
            style: AppTextStyles.h4,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 6000000,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String party = results[groupIndex].party;
                      return BarTooltipItem(
                        '$party\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: NumberFormat.compact().format(rod.toY.round()),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          space: 4,
                          meta: meta,
                          child: Text(
                            results[value.toInt()].party,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 56,
                      getTitlesWidget: (value, meta) {
                        String text = '';
                        if (value == 0) {
                          text = '0';
                        } else if (value == 1000000) {
                          text = '1M';
                        } else if (value == 2000000) {
                          text = '2M';
                        } else if (value == 3000000) {
                          text = '3M';
                        } else if (value == 4000000) {
                          text = '4M';
                        } else if (value == 5000000) {
                          text = '5M';
                        } else if (value == 6000000) {
                          text = '6M';
                        }
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(text, style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          )),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: results.asMap().entries.map((entry) {
                  int index = entry.key;
                  PartyResult result = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: result.votes.toDouble(),
                        color: _partyColors[result.party] ?? Colors.blue,
                        width: 22,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieCharts(List<PartyResult> results) {
    // Calculate percentages for pie charts
    double totalCandidates = results.fold(0, (sum, result) => sum + result.candidates);
    double totalSeats = results.fold(0, (sum, result) => sum + result.seats);

    // Calculate real percentages for each party
    Map<String, double> candidatePercentages = {};
    Map<String, double> seatPercentages = {};

    for (var result in results) {
      candidatePercentages[result.party] = (result.candidates / totalCandidates) * 100;
      seatPercentages[result.party] = (result.seats / totalSeats) * 100;
    }

    List<PieChartSectionData> candidateSections = results.map((result) {
      double percentage = candidatePercentages[result.party] ?? 0;
      return PieChartSectionData(
        color: _partyColors[result.party] ?? Colors.blue,
        value: result.candidates.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    List<PieChartSectionData> seatsSections = results.map((result) {
      double percentage = seatPercentages[result.party] ?? 0;
      return PieChartSectionData(
        color: _partyColors[result.party] ?? Colors.blue,
        value: result.seats.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 80,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    // Calculate total elected candidates
    int totalElectedCandidates = results.fold(0, (sum, result) => sum + result.electedCandidates);

    // Calculate real percentages for elected candidates (will be used in the tables)
    Map<String, double> electedPercentages = {};
    for (var result in results) {
      electedPercentages[result.party] = (result.electedCandidates / totalElectedCandidates) * 100;
    }

    return LayoutBuilder(
        builder: (context, constraints) {
          // For small screens, stack charts vertically
          if (constraints.maxWidth < 600) {
            return Column(
              children: [
                _buildSinglePieChart(
                  "Nombre de candidats par groupement/parti politique",
                  candidateSections,
                  results,
                  totalCandidates.toInt(),
                  totalElectedCandidates,
                  electedPercentages,
                  true,
                ),
                const SizedBox(height: 16),
                _buildSinglePieChart(
                  "Sièges à pourvoir obtenus par groupement/parti politique",
                  seatsSections,
                  results,
                  totalSeats.toInt(),
                  null,
                  seatPercentages,
                  false,
                ),
              ],
            );
          }

          // For larger screens, place charts side by side
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildSinglePieChart(
                  "Nombre de candidats par groupement/parti politique",
                  candidateSections,
                  results,
                  totalCandidates.toInt(),
                  totalElectedCandidates,
                  electedPercentages,
                  true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSinglePieChart(
                  "Sièges à pourvoir obtenus par groupement/parti politique",
                  seatsSections,
                  results,
                  totalSeats.toInt(),
                  null,
                  seatPercentages,
                  false,
                ),
              ),
            ],
          );
        }
    );
  }

  Widget _buildSinglePieChart(
      String title,
      List<PieChartSectionData> sections,
      List<PartyResult> results,
      int total,
      int? totalElected,
      Map<String, double> percentages,
      bool showElected,
      ) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.h4,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: sections,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...results.map((result) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            result.party,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (showElected)
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: "${result.candidates} ",
                                  ),
                                  TextSpan(
                                    text: "(${result.electedCandidates} élus)",
                                    style: const TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " soit ${percentages[result.party]?.toStringAsFixed(1)}%",
                                  ),
                                ],
                              ),
                            )
                          else
                            Text(
                              "${result.seats} soit ${percentages[result.party]?.toStringAsFixed(1)}%",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.grey.shade300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        showElected ? "TOTAL CANDIDATS" : "TOTAL SIÈGES",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (showElected)
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "$total ",
                              ),
                              TextSpan(
                                text: "($totalElected élus)",
                                style: const TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                              const TextSpan(
                                text: " soit 100%",
                              ),
                            ],
                          ),
                        )
                      else
                        Text(
                          "$total soit 100%",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 16,
        runSpacing: 12,
        children: _partyColors.entries.map((entry) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: entry.value,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                entry.key,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    if (_tabController == null) return const SizedBox();

    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppColors.primary,
        tabs: _departments.map((department) {
          return Tab(text: department);
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_tabController == null) return const SizedBox();

    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: _departments.map((department) {
          List<PartyResult> resultsToShow;
          if (department == 'National') {
            resultsToShow = _nationalResults;
          } else {
            resultsToShow = _departmentResults[department] ?? [];
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildBarChart(resultsToShow),
                const SizedBox(height: 16),
                _buildPartyLegend(),
                const SizedBox(height: 16),
                _buildPieCharts(resultsToShow),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Résultats détaillés"),
          elevation: 0,
        ),
        body: _isLoading
            ? _buildLoadingIndicator()
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildHeader(),
            ),
            _buildTabBar(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }
}

class PartyResult {
  final String party;
  final int votes;
  final int seats;
  final int candidates;
  final int electedCandidates;

  PartyResult({
    required this.party,
    required this.votes,
    required this.seats,
    required this.candidates,
    required this.electedCandidates,
  });
}