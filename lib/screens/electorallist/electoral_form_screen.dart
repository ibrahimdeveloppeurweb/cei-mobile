import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:cei_mobile/repository/common_repos.dart';
import 'package:cei_mobile/repository/electoral_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'model/electoral_request_model.dart';

class ElectoralFormScreen extends StatefulWidget {
  const ElectoralFormScreen({super.key});

  @override
  State<ElectoralFormScreen> createState() => _ElectoralFormScreenState();
}

class _ElectoralFormScreenState extends State<ElectoralFormScreen> {
  final GlobalKey _formKey = GlobalKey();


  bool _isLoading = false;
  bool _isSubmitting = false;
  bool _isDisposed = false;

  final TextEditingController _motifController = TextEditingController();

  final List<Map<String, dynamic>> _typesAcces = [
    {"value": "lecture", "name": "Lecture seule"},
    {"value": "telecharger", "name": "Télécharger"}
  ];

  final List<Map<String, dynamic>> _typesList = [
    {"value": "provisoire", "name": "Liste provisoire"},
    {"value": "definitive", "name": "Liste définitive"}
  ];

  List<AnneeModel> _annees = [];
  List<DistrictModel> _districts = [];
  List<RegionModel> _regions = [];
  List<DepartementModel> _departements = [];
  List<SousPrefectureModel> _sousPrefectures = [];
  List<CommuneModel> _communes = [];

  // Valeurs sélectionnées
  AnneeModel? _selectedAnnee;
  DistrictModel? _selectedDistrict;
  RegionModel? _selectedRegion;
  DepartementModel? _selectedDepartement;
  SousPrefectureModel? _selectedSousPrefecture;
  CommuneModel? _selectedCommune;
  String _selectedTypeAcces = 'lecture';
  String _selectedTypeList = 'provisoire';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });

    // Initialize defaults
    _selectedTypeAcces = 'lecture';
    _selectedTypeList = 'provisoire';
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark as disposed
    _motifController.dispose();
    super.dispose();
  }

  // Chargement des données initiales (annees et districts)
  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);

    try {
      // Charger les années
      final anneeResponse = await getAnnees();
      _annees = (anneeResponse as List)
          .map((item) => AnneeModel.fromJson(item))
          .toList();
      if (_annees.isNotEmpty) {
        _selectedAnnee = _annees.first;
      }
    } catch (e) {
      toast('Échec du chargement des années: $e');
    } finally {
      setState(() {});
    }

    try {
      final districtsResponse = await getDistricts();
      _districts = (districtsResponse as List)
          .map((item) => DistrictModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      if (!_isDisposed) {
        toast('Échec du chargement des districts: $e', print: true);
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadRegions() async {
    if (_selectedDistrict == null) return;

    setState(() {
      _isLoading = true;
      _regions = [];
      _selectedRegion = null;
    });

    try {
      final response = await getRegions(districtId: _selectedDistrict?.id);
      _regions = (response as List)
          .map((item) => RegionModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load regions: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadDepartements() async {
    if (_selectedRegion == null) return;

    setState(() {
      _isLoading = true;
      _departements = [];
      _selectedDepartement = null;
    });

    try {
      final response = await getDepartements(
        districtId: _selectedDistrict?.id,
        regionId: _selectedRegion?.id,
      );
      _departements = (response as List)
          .map((item) => DepartementModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load departments: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadSousPrefectures() async {
    if (_selectedDepartement == null) return;

    setState(() {
      _isLoading = true;
      _sousPrefectures = [];
      _selectedSousPrefecture = null;
    });

    try {
      final response = await getSousPrefectures(
        districtId: _selectedDistrict?.id,
        regionId: _selectedRegion?.id,
        departementId: _selectedDepartement?.id,
      );
      _sousPrefectures = (response as List)
          .map((item) => SousPrefectureModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load sous-prefectures: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadCommunes() async {
    if (_selectedSousPrefecture == null) return;

    setState(() {
      _isLoading = true;
      _communes = [];
      _selectedCommune = null;
    });

    try {
      final response = await getCommunes(
        districtId: _selectedDistrict?.id,
        regionId: _selectedRegion?.id,
        departementId: _selectedDepartement?.id,
        sousPrefId: _selectedSousPrefecture?.id,
      );
      _communes = (response as List)
          .map((item) => CommuneModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load communes: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _submitRequest() async {
    if (_isSubmitting) return; // Prevent multiple submissions

    // Validation checks
    if (_selectedAnnee == null) {
      toast('Veuillez sélectionner une année');
      return;
    }

    if (_selectedTypeAcces.isEmpty) {
      toast('Veuillez sélectionner un type d\'accès');
      return;
    }

    if (_selectedTypeList.isEmpty) {
      toast('Veuillez sélectionner un type de liste');
      return;
    }

    if (_motifController.text.isEmpty) {
      toast('Veuillez saisir une raison');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _isLoading = true;
    });

    try {
      Map<String, dynamic> requestData = {
        "anneeId": _selectedAnnee?.id,
        "districtId": _selectedDistrict?.id,
        "regionId": _selectedRegion?.id,
        "departementId": _selectedDepartement?.id,
        "sousPrefectureId": _selectedSousPrefecture?.id,
        "communeId": _selectedCommune?.id,
        "typeAcces": _selectedTypeAcces,
        "typeList": _selectedTypeList,
        "motif": _motifController.text
      };

      await submitElectoralListRequestApi(requestData);

      final newRequest = ElectoralRequest(
        id: (DateTime.now().millisecondsSinceEpoch % 10000).toString(),
        status: RequestStatus.pending,
        date:
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        motif: _motifController.text,
        annee: _selectedAnnee?.name ?? '',
        district: _selectedDistrict?.name ?? '',
        region: _selectedRegion?.name,
        departement: _selectedDepartement?.name,
        sousPrefecture: _selectedSousPrefecture?.name,
        commune: _selectedCommune?.name,
        typeAcces: _typesAcces
            .firstWhere((t) => t['value'] == _selectedTypeAcces)['name'],
        typeList: _typesList
            .firstWhere((t) => t['value'] == _selectedTypeList)['name'],
      );
      setState(() {
        _isSubmitting = false;
        _isLoading = false;
      });
      if (mounted) {
        GoRouter.of(context).pop();
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _isLoading = false;
        });
        toast('Erreur lors de la soumission: $error');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
           _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle demande d\'accès'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildRequestForm(),
            ),
          ),
          if (_isSubmitting || _isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  // Formulaire de demande
  Widget _buildRequestForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Demande d'accès à la liste électorale",
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Pour des raisons de sécurité et de confidentialité, l'accès à la liste électorale est soumis à autorisation préalable.",
            style: AppTextStyles.body1,
          ),
          const SizedBox(height: 24),

          // Année
          const Text(
            'Année',
            style: AppTextStyles.body2,
          ),
          DropdownSearch<AnneeModel>(
            items: (f, n) => _annees,
            selectedItem: _selectedAnnee,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Rechercher...",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              searchDelay: const Duration(milliseconds: 0),
              itemBuilder: (context, item, _, isSelected) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    item.name ?? '',
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
            onChanged: (value) {
              setState(() {
                _selectedAnnee = value;
              });
            },
            itemAsString: (item) => item.name ?? '',
            validator: (value) => value == null ? 'L\'année est requise' : null,
          ),
          const SizedBox(height: 16),

          // District
          const Text(
            'District',
            style: AppTextStyles.body2,
          ),
          DropdownSearch<DistrictModel>(
            items: (f, n) => _districts,
            selectedItem: _selectedDistrict,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
              searchFieldProps: const TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Rechercher...",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
              ),
              searchDelay: const Duration(milliseconds: 0),
              itemBuilder: (context, item, _, isSelected) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    item.name ?? '',
                    style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
            onChanged: (value) async {
              setState(() {
                _selectedDistrict = value;
                // Reset all dependent fields
                _selectedRegion = null;
                _selectedDepartement = null;
                _selectedSousPrefecture = null;
                _selectedCommune = null;
                _regions = [];
                _departements = [];
                _sousPrefectures = [];
                _communes = [];
              });

              if (value != null) {
                await _loadRegions();
              }
            },
            itemAsString: (item) => item.name ?? '',
            validator: (value) =>
                value == null ? 'Le district est requis' : null,
          ),
          const SizedBox(height: 16),

          // Région
          const Text(
            'Région',
            style: AppTextStyles.body2,
          ),
          DropdownSearch<RegionModel>(
            items: (f, n) => _regions,
            selectedItem: _selectedRegion,
            enabled: _selectedDistrict != null,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            onChanged: (value) async {
              setState(() {
                _selectedRegion = value;
                // Reset dependent fields
                _selectedDepartement = null;
                _selectedSousPrefecture = null;
                _selectedCommune = null;
                _departements = [];
                _sousPrefectures = [];
                _communes = [];
              });

              if (value != null) {
                await _loadDepartements();
              }
            },
            itemAsString: (item) => item.name ?? '',
            validator: (value) => value == null && _selectedDistrict != null
                ? 'La région est requise'
                : null,
          ),
          const SizedBox(height: 16),

          // Département
          const Text(
            'Département',
            style: AppTextStyles.body2,
          ),
          DropdownSearch<DepartementModel>(
            items: (f, n) => _departements,
            selectedItem: _selectedDepartement,
            enabled: _selectedRegion != null,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            onChanged: (value) async {
              setState(() {
                _selectedDepartement = value;
                // Reset dependent fields
                _selectedSousPrefecture = null;
                _selectedCommune = null;
                _sousPrefectures = [];
                _communes = [];
              });

              if (value != null) {
                await _loadSousPrefectures();
              }
            },
            itemAsString: (item) => item.name ?? '',
            validator: (value) => value == null && _selectedRegion != null
                ? 'Le département est requis'
                : null,
          ),
          const SizedBox(height: 16),

          // Sous-préfecture
          const Text(
            'Sous-Préfecture',
            style: AppTextStyles.body2,
          ),
          DropdownSearch<SousPrefectureModel>(
            items: (f, n) => _sousPrefectures,
            selectedItem: _selectedSousPrefecture,
            enabled: _selectedDepartement != null,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            onChanged: (value) async {
              setState(() {
                _selectedSousPrefecture = value;
                // Reset dependent fields
                _selectedCommune = null;
                _communes = [];
              });

              if (value != null) {
                await _loadCommunes();
              }
            },
            itemAsString: (item) => item.name ?? '',
            validator: (value) => value == null && _selectedDepartement != null
                ? 'La sous-préfecture est requise'
                : null,
          ),
          const SizedBox(height: 16),

          // Commune
          const Text(
            'Commune',
            style: AppTextStyles.body2,
          ),
          DropdownSearch<CommuneModel>(
            items: (f, n) => _communes,
            selectedItem: _selectedCommune,
            enabled: _selectedSousPrefecture != null,
            compareFn: (item1, item2) => item1.id == item2.id,
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            onChanged: (value) {
              setState(() {
                _selectedCommune = value;
              });
            },
            itemAsString: (item) => item.name ?? '',
            validator: (value) =>
                value == null && _selectedSousPrefecture != null
                    ? 'La commune est requise'
                    : null,
          ),
          const SizedBox(height: 16),

          // Type d'accès
          const Text(
            "Type d'accès",
            style: AppTextStyles.body2,
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: _selectedTypeAcces,
            items: _typesAcces.map((item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Text(item['name']),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedTypeAcces = value;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez sélectionner un type d'accès";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Type de liste
          const Text(
            "Type de liste",
            style: AppTextStyles.body2,
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            value: _selectedTypeList,
            items: _typesList.map((item) {
              return DropdownMenuItem<String>(
                value: item['value'],
                child: Text(item['name']),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedTypeList = value;
                });
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez sélectionner un type de liste";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Motif
          const Text(
            "Motif de la demande",
            style: AppTextStyles.body2,
          ),
          TextFormField(
            controller: _motifController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  "Expliquez pourquoi vous avez besoin d'accéder à la liste électorale",
            ),
            maxLines: 4,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez saisir un motif";
              }
              if (value.length < 20) {
                return "Veuillez fournir un motif plus détaillé";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Boutons d'action
          Row(
            children: [
              Expanded(
                child: AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: Colors.grey,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('Annuler',
                      style: boldTextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: AppColors.primary,
                  onTap: _isSubmitting ? null : _submitRequest,
                  child: Text('Soumettre',
                      style: boldTextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
