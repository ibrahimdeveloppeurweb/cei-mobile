import 'package:flutter/material.dart';

class CountrySelectionScreen extends StatefulWidget {
  final String selectedCode;

  const CountrySelectionScreen({super.key, required this.selectedCode});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredCountries = [];

  final List<Map<String, String>> countryCodes = [
    {'code': '+93', 'flag': '🇦🇫', 'name': 'Afghanistan'},
    {'code': '+27', 'flag': '🇿🇦', 'name': 'Afrique du Sud'},
    {'code': '+355', 'flag': '🇦🇱', 'name': 'Albanie'},
    {'code': '+213', 'flag': '🇩🇿', 'name': 'Algérie'},
    {'code': '+49', 'flag': '🇩🇪', 'name': 'Allemagne'},
    {'code': '+376', 'flag': '🇦🇩', 'name': 'Andorre'},
    {'code': '+244', 'flag': '🇦🇴', 'name': 'Angola'},
    {'code': '+1', 'flag': '🇦🇮', 'name': 'Anguilla'},
    {'code': '+1', 'flag': '🇦🇬', 'name': 'Antigua-et-Barbuda'},
    {'code': '+966', 'flag': '🇸🇦', 'name': 'Arabie saoudite'},
    {'code': '+54', 'flag': '🇦🇷', 'name': 'Argentine'},
    {'code': '+374', 'flag': '🇦🇲', 'name': 'Arménie'},
    {'code': '+297', 'flag': '🇦🇼', 'name': 'Aruba'},
    {'code': '+61', 'flag': '🇦🇺', 'name': 'Australie'},
    {'code': '+43', 'flag': '🇦🇹', 'name': 'Autriche'},
    {'code': '+994', 'flag': '🇦🇿', 'name': 'Azerbaïdjan'},
    {'code': '+1', 'flag': '🇧🇸', 'name': 'Bahamas'},
    {'code': '+973', 'flag': '🇧🇭', 'name': 'Bahreïn'},
    {'code': '+880', 'flag': '🇧🇩', 'name': 'Bangladesh'},
    {'code': '+1', 'flag': '🇧🇧', 'name': 'Barbade'},
    {'code': '+375', 'flag': '🇧🇾', 'name': 'Biélorussie'},
    {'code': '+32', 'flag': '🇧🇪', 'name': 'Belgique'},
    {'code': '+501', 'flag': '🇧🇿', 'name': 'Belize'},
    {'code': '+229', 'flag': '🇧🇯', 'name': 'Bénin'},
    {'code': '+1', 'flag': '🇧🇲', 'name': 'Bermudes'},
    {'code': '+975', 'flag': '🇧🇹', 'name': 'Bhoutan'},
    {'code': '+591', 'flag': '🇧🇴', 'name': 'Bolivie'},
    {'code': '+387', 'flag': '🇧🇦', 'name': 'Bosnie-Herzégovine'},
    {'code': '+267', 'flag': '🇧🇼', 'name': 'Botswana'},
    {'code': '+55', 'flag': '🇧🇷', 'name': 'Brésil'},
    {'code': '+673', 'flag': '🇧🇳', 'name': 'Brunei'},
    {'code': '+359', 'flag': '🇧🇬', 'name': 'Bulgarie'},
    {'code': '+226', 'flag': '🇧🇫', 'name': 'Burkina Faso'},
    {'code': '+257', 'flag': '🇧🇮', 'name': 'Burundi'},
    {'code': '+855', 'flag': '🇰🇭', 'name': 'Cambodge'},
    {'code': '+237', 'flag': '🇨🇲', 'name': 'Cameroun'},
    {'code': '+1', 'flag': '🇨🇦', 'name': 'Canada'},
    {'code': '+238', 'flag': '🇨🇻', 'name': 'Cap-Vert'},
    {'code': '+56', 'flag': '🇨🇱', 'name': 'Chili'},
    {'code': '+86', 'flag': '🇨🇳', 'name': 'Chine'},
    {'code': '+357', 'flag': '🇨🇾', 'name': 'Chypre'},
    {'code': '+57', 'flag': '🇨🇴', 'name': 'Colombie'},
    {'code': '+269', 'flag': '🇰🇲', 'name': 'Comores'},
    {'code': '+242', 'flag': '🇨🇬', 'name': 'Congo'},
    {'code': '+243', 'flag': '🇨🇩', 'name': 'Congo (RDC)'},
    {'code': '+850', 'flag': '🇰🇵', 'name': 'Corée du Nord'},
    {'code': '+82', 'flag': '🇰🇷', 'name': 'Corée du Sud'},
    {'code': '+506', 'flag': '🇨🇷', 'name': 'Costa Rica'},
    {'code': '+225', 'flag': '🇨🇮', 'name': 'Côte d\'Ivoire'},
    {'code': '+385', 'flag': '🇭🇷', 'name': 'Croatie'},
    {'code': '+53', 'flag': '🇨🇺', 'name': 'Cuba'},
    {'code': '+45', 'flag': '🇩🇰', 'name': 'Danemark'},
    {'code': '+253', 'flag': '🇩🇯', 'name': 'Djibouti'},
    {'code': '+1', 'flag': '🇩🇴', 'name': 'République dominicaine'},
    {'code': '+20', 'flag': '🇪🇬', 'name': 'Égypte'},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'Émirats arabes unis'},
    {'code': '+593', 'flag': '🇪🇨', 'name': 'Équateur'},
    {'code': '+291', 'flag': '🇪🇷', 'name': 'Érythrée'},
    {'code': '+34', 'flag': '🇪🇸', 'name': 'Espagne'},
    {'code': '+372', 'flag': '🇪🇪', 'name': 'Estonie'},
    {'code': '+1', 'flag': '🇺🇸', 'name': 'États-Unis'},
    {'code': '+251', 'flag': '🇪🇹', 'name': 'Éthiopie'},
    {'code': '+358', 'flag': '🇫🇮', 'name': 'Finlande'},
    {'code': '+33', 'flag': '🇫🇷', 'name': 'France'},
    {'code': '+241', 'flag': '🇬🇦', 'name': 'Gabon'},
    {'code': '+220', 'flag': '🇬🇲', 'name': 'Gambie'},
    {'code': '+995', 'flag': '🇬🇪', 'name': 'Géorgie'},
    {'code': '+233', 'flag': '🇬🇭', 'name': 'Ghana'},
    {'code': '+350', 'flag': '🇬🇮', 'name': 'Gibraltar'},
    {'code': '+30', 'flag': '🇬🇷', 'name': 'Grèce'},
    {'code': '+1', 'flag': '🇬🇩', 'name': 'Grenade'},
    {'code': '+299', 'flag': '🇬🇱', 'name': 'Groenland'},
    {'code': '+1', 'flag': '🇬🇵', 'name': 'Guadeloupe'},
    {'code': '+1', 'flag': '🇬🇺', 'name': 'Guam'},
    {'code': '+502', 'flag': '🇬🇹', 'name': 'Guatemala'},
    {'code': '+224', 'flag': '🇬🇳', 'name': 'Guinée'},
    {'code': '+245', 'flag': '🇬🇼', 'name': 'Guinée-Bissau'},
    {'code': '+592', 'flag': '🇬🇾', 'name': 'Guyana'},
    {'code': '+509', 'flag': '🇭🇹', 'name': 'Haïti'},
    {'code': '+504', 'flag': '🇭🇳', 'name': 'Honduras'},
    {'code': '+852', 'flag': '🇭🇰', 'name': 'Hong Kong'},
    {'code': '+36', 'flag': '🇭🇺', 'name': 'Hongrie'},
    {'code': '+91', 'flag': '🇮🇳', 'name': 'Inde'},
    {'code': '+62', 'flag': '🇮🇩', 'name': 'Indonésie'},
    {'code': '+98', 'flag': '🇮🇷', 'name': 'Iran'},
    {'code': '+964', 'flag': '🇮🇶', 'name': 'Irak'},
    {'code': '+353', 'flag': '🇮🇪', 'name': 'Irlande'},
    {'code': '+354', 'flag': '🇮🇸', 'name': 'Islande'},
    {'code': '+972', 'flag': '🇮🇱', 'name': 'Israël'},
    {'code': '+39', 'flag': '🇮🇹', 'name': 'Italie'},
    {'code': '+1', 'flag': '🇯🇲', 'name': 'Jamaïque'},
    {'code': '+81', 'flag': '🇯🇵', 'name': 'Japon'},
    {'code': '+962', 'flag': '🇯🇴', 'name': 'Jordanie'},
    {'code': '+7', 'flag': '🇰🇿', 'name': 'Kazakhstan'},
    {'code': '+254', 'flag': '🇰🇪', 'name': 'Kenya'},
    {'code': '+996', 'flag': '🇰🇬', 'name': 'Kirghizistan'},
    {'code': '+686', 'flag': '🇰🇮', 'name': 'Kiribati'},
    {'code': '+965', 'flag': '🇰🇼', 'name': 'Koweït'},
    {'code': '+856', 'flag': '🇱🇦', 'name': 'Laos'},
    {'code': '+266', 'flag': '🇱🇸', 'name': 'Lesotho'},
    {'code': '+371', 'flag': '🇱🇻', 'name': 'Lettonie'},
    {'code': '+961', 'flag': '🇱🇧', 'name': 'Liban'},
    {'code': '+231', 'flag': '🇱🇷', 'name': 'Libéria'},
    {'code': '+218', 'flag': '🇱🇾', 'name': 'Libye'},
    {'code': '+423', 'flag': '🇱🇮', 'name': 'Liechtenstein'},
    {'code': '+370', 'flag': '🇱🇹', 'name': 'Lituanie'},
    {'code': '+352', 'flag': '🇱🇺', 'name': 'Luxembourg'},
    {'code': '+853', 'flag': '🇲🇴', 'name': 'Macao'},
    {'code': '+389', 'flag': '🇲🇰', 'name': 'Macédoine du Nord'},
    {'code': '+261', 'flag': '🇲🇬', 'name': 'Madagascar'},
    {'code': '+60', 'flag': '🇲🇾', 'name': 'Malaisie'},
    {'code': '+265', 'flag': '🇲🇼', 'name': 'Malawi'},
    {'code': '+960', 'flag': '🇲🇻', 'name': 'Maldives'},
    {'code': '+223', 'flag': '🇲🇱', 'name': 'Mali'},
    {'code': '+356', 'flag': '🇲🇹', 'name': 'Malte'},
    {'code': '+212', 'flag': '🇲🇦', 'name': 'Maroc'},
    {'code': '+692', 'flag': '🇲🇭', 'name': 'Îles Marshall'},
    {'code': '+596', 'flag': '🇲🇶', 'name': 'Martinique'},
    {'code': '+230', 'flag': '🇲🇺', 'name': 'Maurice'},
    {'code': '+222', 'flag': '🇲🇷', 'name': 'Mauritanie'},
    {'code': '+262', 'flag': '🇾🇹', 'name': 'Mayotte'},
    {'code': '+52', 'flag': '🇲🇽', 'name': 'Mexique'},
    {'code': '+691', 'flag': '🇫🇲', 'name': 'Micronésie'},
    {'code': '+373', 'flag': '🇲🇩', 'name': 'Moldavie'},
    {'code': '+377', 'flag': '🇲🇨', 'name': 'Monaco'},
    {'code': '+976', 'flag': '🇲🇳', 'name': 'Mongolie'},
    {'code': '+382', 'flag': '🇲🇪', 'name': 'Monténégro'},
    {'code': '+1', 'flag': '🇲🇸', 'name': 'Montserrat'},
    {'code': '+258', 'flag': '🇲🇿', 'name': 'Mozambique'},
    {'code': '+95', 'flag': '🇲🇲', 'name': 'Myanmar'},
    {'code': '+264', 'flag': '🇳🇦', 'name': 'Namibie'},
    {'code': '+674', 'flag': '🇳🇷', 'name': 'Nauru'},
    {'code': '+977', 'flag': '🇳🇵', 'name': 'Népal'},
    {'code': '+505', 'flag': '🇳🇮', 'name': 'Nicaragua'},
    {'code': '+227', 'flag': '🇳🇪', 'name': 'Niger'},
    {'code': '+234', 'flag': '🇳🇬', 'name': 'Nigéria'},
    {'code': '+683', 'flag': '🇳🇺', 'name': 'Niue'},
    {'code': '+47', 'flag': '🇳🇴', 'name': 'Norvège'},
    {'code': '+687', 'flag': '🇳🇨', 'name': 'Nouvelle-Calédonie'},
    {'code': '+64', 'flag': '🇳🇿', 'name': 'Nouvelle-Zélande'},
    {'code': '+968', 'flag': '🇴🇲', 'name': 'Oman'},
    {'code': '+256', 'flag': '🇺🇬', 'name': 'Ouganda'},
    {'code': '+998', 'flag': '🇺🇿', 'name': 'Ouzbékistan'},
    {'code': '+92', 'flag': '🇵🇰', 'name': 'Pakistan'},
    {'code': '+680', 'flag': '🇵🇼', 'name': 'Palaos'},
    {'code': '+507', 'flag': '🇵🇦', 'name': 'Panama'},
    {'code': '+675', 'flag': '🇵🇬', 'name': 'Papouasie-Nouvelle-Guinée'},
    {'code': '+595', 'flag': '🇵🇾', 'name': 'Paraguay'},
    {'code': '+31', 'flag': '🇳🇱', 'name': 'Pays-Bas'},
    {'code': '+51', 'flag': '🇵🇪', 'name': 'Pérou'},
    {'code': '+63', 'flag': '🇵🇭', 'name': 'Philippines'},
    {'code': '+48', 'flag': '🇵🇱', 'name': 'Pologne'},
    {'code': '+689', 'flag': '🇵🇫', 'name': 'Polynésie française'},
    {'code': '+1', 'flag': '🇵🇷', 'name': 'Porto Rico'},
    {'code': '+351', 'flag': '🇵🇹', 'name': 'Portugal'},
    {'code': '+974', 'flag': '🇶🇦', 'name': 'Qatar'},
    {'code': '+262', 'flag': '🇷🇪', 'name': 'Réunion'},
    {'code': '+40', 'flag': '🇷🇴', 'name': 'Roumanie'},
    {'code': '+44', 'flag': '🇬🇧', 'name': 'Royaume-Uni'},
    {'code': '+7', 'flag': '🇷🇺', 'name': 'Russie'},
    {'code': '+250', 'flag': '🇷🇼', 'name': 'Rwanda'},
    {'code': '+1', 'flag': '🇰🇳', 'name': 'Saint-Christophe-et-Niévès'},
    {'code': '+378', 'flag': '🇸🇲', 'name': 'Saint-Marin'},
    {'code': '+1', 'flag': '🇻🇨', 'name': 'Saint-Vincent-et-les-Grenadines'},
    {'code': '+1', 'flag': '🇱🇨', 'name': 'Sainte-Lucie'},
    {'code': '+685', 'flag': '🇼🇸', 'name': 'Samoa'},
    {'code': '+239', 'flag': '🇸🇹', 'name': 'Sao Tomé-et-Principe'},
    {'code': '+221', 'flag': '🇸🇳', 'name': 'Sénégal'},
    {'code': '+381', 'flag': '🇷🇸', 'name': 'Serbie'},
    {'code': '+248', 'flag': '🇸🇨', 'name': 'Seychelles'},
    {'code': '+232', 'flag': '🇸🇱', 'name': 'Sierra Leone'},
    {'code': '+65', 'flag': '🇸🇬', 'name': 'Singapour'},
    {'code': '+421', 'flag': '🇸🇰', 'name': 'Slovaquie'},
    {'code': '+386', 'flag': '🇸🇮', 'name': 'Slovénie'},
    {'code': '+677', 'flag': '🇸🇧', 'name': 'Îles Salomon'},
    {'code': '+252', 'flag': '🇸🇴', 'name': 'Somalie'},
    {'code': '+249', 'flag': '🇸🇩', 'name': 'Soudan'},
    {'code': '+211', 'flag': '🇸🇸', 'name': 'Soudan du Sud'},
    {'code': '+94', 'flag': '🇱🇰', 'name': 'Sri Lanka'},
    {'code': '+46', 'flag': '🇸🇪', 'name': 'Suède'},
    {'code': '+41', 'flag': '🇨🇭', 'name': 'Suisse'},
    {'code': '+597', 'flag': '🇸🇷', 'name': 'Suriname'},
    {'code': '+268', 'flag': '🇸🇿', 'name': 'Eswatini'},
    {'code': '+963', 'flag': '🇸🇾', 'name': 'Syrie'},
    {'code': '+992', 'flag': '🇹🇯', 'name': 'Tadjikistan'},
    {'code': '+886', 'flag': '🇹🇼', 'name': 'Taïwan'},
    {'code': '+255', 'flag': '🇹🇿', 'name': 'Tanzanie'},
    {'code': '+235', 'flag': '🇹🇩', 'name': 'Tchad'},
    {'code': '+420', 'flag': '🇨🇿', 'name': 'République tchèque'},
    {'code': '+66', 'flag': '🇹🇭', 'name': 'Thaïlande'},
    {'code': '+670', 'flag': '🇹🇱', 'name': 'Timor-Leste'},
    {'code': '+228', 'flag': '🇹🇬', 'name': 'Togo'},
    {'code': '+676', 'flag': '🇹🇴', 'name': 'Tonga'},
    {'code': '+1', 'flag': '🇹🇹', 'name': 'Trinité-et-Tobago'},
    {'code': '+216', 'flag': '🇹🇳', 'name': 'Tunisie'},
    {'code': '+993', 'flag': '🇹🇲', 'name': 'Turkménistan'},
    {'code': '+90', 'flag': '🇹🇷', 'name': 'Turquie'},
    {'code': '+688', 'flag': '🇹🇻', 'name': 'Tuvalu'},
    {'code': '+380', 'flag': '🇺🇦', 'name': 'Ukraine'},
    {'code': '+598', 'flag': '🇺🇾', 'name': 'Uruguay'},
    {'code': '+678', 'flag': '🇻🇺', 'name': 'Vanuatu'},
    {'code': '+39', 'flag': '🇻🇦', 'name': 'Vatican'},
    {'code': '+58', 'flag': '🇻🇪', 'name': 'Venezuela'},
    {'code': '+84', 'flag': '🇻🇳', 'name': 'Vietnam'},
    {'code': '+967', 'flag': '🇾🇪', 'name': 'Yémen'},
    {'code': '+260', 'flag': '🇿🇲', 'name': 'Zambie'},
    {'code': '+263', 'flag': '🇿🇼', 'name': 'Zimbabwe'},
  ];

  @override
  void initState() {
    super.initState();
    filteredCountries = countryCodes;
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCountries = countryCodes;
      } else {
        filteredCountries = countryCodes.where((country) {
          return country['name']!.toLowerCase().contains(query.toLowerCase()) ||
              country['code']!.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Liste des pays',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Sélectionnez votre pays',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Barre de recherche
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: searchController,
              onChanged: _filterCountries,
              decoration: const InputDecoration(
                hintText: 'Rechercher un pays',

                border: InputBorder.none,
              ),
            ),
          ),

          // Liste des pays
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final isSelected = country['code'] == widget.selectedCode;

                return InkWell(
                  onTap: () {
                    Navigator.pop(context, country);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[50] : Colors.white,
                      border: const Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          country['flag']!,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            '${country['name']}(${country['code']})',
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.blue : Colors.black,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: Colors.blue,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}