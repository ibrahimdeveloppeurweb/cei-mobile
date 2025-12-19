import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_verification_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_filex/open_filex.dart';

final String _article12Content = '''
ARTICLE 12 : RÉCLAMATION

Tout électeur inscrit sur la liste de la circonscription électorale peut réclamer l'inscription d'une personne omise. 

Tout électeur a le droit de réclamer la radiation d'une personne décédée, de celle qui a perdu sa qualité d'électeur, de celle dont la radiation a été ordonnée par décision de l'autorité compétente ou d'une personne indûment inscrite.

Ces mêmes droits peuvent être exercés par chacun des membres de la Commission chargée des élections.

Les demandes émanant des tiers ne peuvent avoir pour objet que des inscriptions ou des radiations éventuelles et doivent préciser le nom de chacun de ceux dont l'inscription ou la radiation est réclamée.

La réclamation écrite et motivée est adressée à la Commission chargée des élections.

La décision de la Commission chargée des élections est susceptible de recours devant le président du tribunal territorialement compétent sans frais, par déclaration au greffe dans le délai de trois jours à compter de son prononcé.

La décision du président du tribunal est rendue dans le délai de cinq jours à compter de sa saisine. Elle ne fait l'objet d'aucun recours.

La charge de la preuve incombe au demandeur.

Les omissions et irrégularités matérielles constatées par l'intéressé ou par la Commission chargée des élections relatives à la mention des noms, prénoms, sexe, profession, résidence ou domicile des électeurs, peuvent faire l'objet d'une rectification par la Commission chargée des élections.

TYPES DE RÉCLAMATION:
- Inscription (personne omise)
- Radiation (personne décédée, ayant perdu sa qualité d'électeur, etc.)
- Correction (omissions et irrégularités matérielles)
''';

final String _justificatifNotice = ''' 
Pour les omissions : 
 Récépissé d’enrôlement 
 Extrait d’acte de naissance ou Jugement supplétif en tenant lieu ou 
Expédition (dans le cas des formulaires orphelins, 
inexploitables/invalides, la réclamation ne pourra déboucher sur une 
inscription que s’il est procédé au ré-enrôlement au centre de 
coordination départemental) – les cas de rejets sont des omissions si 
le pétitionnaire est éligible à la qualité d’électeur. 
Pour les radiations de personnes indûment inscrites, selon les cas : 
 Carte nationale d’identité 
 Passeport 
 Carte de séjour 
 Attestation d’identité 
 Décision de déchéance de la nationalité 
 Certificat de mariage 
 Acte d’Etat civil 
 Tout autre document attestant de l’irrégularité de l’inscription au vu 
des conditions d’éligibilité à la qualité d’électeur 
Pour les radiations de personnes décédées : 
 Extrait d’acte de décès 
 Jugement supplétif d’acte de décès 
 Certificat médical de décès 
Pour les radiations de personnes ayant perdu la qualité d’électeur : 
Pour crime : 
 Décision de justice de condamnation, accompagnée d’un certificat de 
non appel et de non opposition 
Pour les faillis non réhabilités : 
 Jugement prononçant la faillite 
Pour les contumaces : 
 Ordonnance de contumace 
Pour les interdits judiciaires (Article 489 du Code civil): 
 Décision de justice ayant prononcé l’interdiction, accompagnée d’un 
certificat de non appel et de non opposition 
Pour les omissions et irrégularités des mentions personnelles 
(nom, prénoms, sexe, profession, résidence ou domicile) : 
 Extrait d’acte de naissance ou Jugement supplétif en tenant lieu ou 
Expédition 
 Carte nationale d’identité 
 Toute autre pièce administrative justifiant les éléments personnels de 
l’identité 

''';
showArticleInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Informations légales',
                    style: AppTextStyles.h3.copyWith(color: AppColors.secondary),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    _article12Content,
                    style: AppTextStyles.body2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: AppColors.primary,
                  onTap: () => Navigator.of(context).pop(),
                  child: Text('Fermer', style: boldTextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class IvoryCoastPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = newValue.text;

    // Remove all non-digit characters
    final cleanedText = newText.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the number starts with a valid Ivory Coast prefix
    if (cleanedText.length >= 2) {
      final prefix = cleanedText.substring(0, 2);
      if (![
        '07', '05', '01', '27', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29'
      ].contains(prefix)) {
        return oldValue; // Reject invalid prefixes
      }
    }

    // Limit the length to 10 digits for all numbers
    if (cleanedText.length > 10) {
      return oldValue; // All numbers must be 10 digits
    }

    // Add spaces for better readability
    String formattedText = cleanedText;
    if (cleanedText.length > 2) {
      formattedText = '${cleanedText.substring(0, 2)} ${cleanedText.substring(2)}';
    }
    if (cleanedText.length > 5) {
      formattedText = '${formattedText.substring(0, 5)} ${formattedText.substring(5)}';
    }
    if (cleanedText.length > 8) {
      formattedText = '${formattedText.substring(0, 8)} ${formattedText.substring(8)}';
    }

    // Ensure no extra spaces are left at the end
    formattedText = formattedText.trim();

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}


class DigitLengthLimitingTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  DigitLengthLimitingTextInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove all non-digit characters
    final cleanedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // If the cleaned text exceeds the max length, return the old value
    if (cleanedText.length > maxLength) {
      return oldValue;
    }

    // Otherwise, allow the new value
    return newValue;
  }
}

class VoterIDInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Remove all non-alphanumeric characters
    final String cleanText = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    // Check if empty
    if (cleanText.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Enforce 'V' as the first character
    String formattedText = '';
    if (cleanText.length >= 1) {
      formattedText = 'V';

      // If user tried to type something else as first character, just use V
      if (cleanText.length > 1 || (cleanText.length == 1 && cleanText[0].toUpperCase() != 'V')) {
        formattedText += ' ';

        // Get numeric part only (ignore any non-V first character)
        String numericPart = cleanText;
        if (cleanText[0].toUpperCase() != 'V') {
          numericPart = cleanText;
        } else {
          numericPart = cleanText.substring(1);
        }

        // Format the numeric part with spaces
        for (int i = 0; i < numericPart.length && i < 10; i++) {
          if (i == 0) {
            formattedText += numericPart[i];
          } else if (i == 4) {
            formattedText += ' ${numericPart[i]}';
          } else if (i == 8) {
            formattedText += ' ${numericPart[i]}';
          } else {
            formattedText += numericPart[i];
          }
        }
      }
    } else {
      formattedText = cleanText;
    }

    // Calculate cursor position
    int cursorPosition = formattedText.length;
    if (newValue.selection.start > 0) {
      // Try to keep cursor relative to its previous position
      cursorPosition = formattedText.length - (newValue.text.length - newValue.selection.start);
      cursorPosition = cursorPosition.clamp(0, formattedText.length);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

/// A simplified formatter that just formats the text without advanced cursor handling
class SimpleVoterIDFormatter {
  static String format(String voterID) {
    // Remove all non-alphanumeric characters
    final String cleanText = voterID.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');

    if (cleanText.isEmpty) {
      return '';
    }

    String formattedText = 'V';
    String numericPart;

    if (cleanText.length > 0 && cleanText[0].toUpperCase() == 'V') {
      numericPart = cleanText.substring(1);
    } else {
      numericPart = cleanText;
    }

    if (numericPart.isNotEmpty) {
      formattedText += ' ${numericPart.substring(0, numericPart.length.clamp(0, 4))}';
    }

    if (numericPart.length > 4) {
      formattedText += ' ${numericPart.substring(4, numericPart.length.clamp(4, 8))}';
    }

    if (numericPart.length > 8) {
      formattedText += ' ${numericPart.substring(8, numericPart.length.clamp(8, 10))}';
    }

    return formattedText;
  }
}
final List<ElectorVerificationResult> fakeElectorData = [
  const ElectorVerificationResult(
    orderNumber: "00145823",
    uniqueRegistrationNumber: "V 0104 0305 68",
    fullName: "KOUASSI JEAN MARC",
    dateOfBirth: "12/05/1985",
    placeOfBirth: "ABIDJAN, CÔTE D'IVOIRE",
    gender: "MASCULIN",
    profession: "INGÉNIEUR",
    residence: "ABOBO, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "KOUASSI EMMANUEL",
    fatherDateOfBirth: "05/03/1955",
    fatherPlaceOfBirth: "BOUAKÉ, CÔTE D'IVOIRE",
    motherName: "YAPI MARIE CLAIRE",
    motherDateOfBirth: "17/08/1957",
    motherPlaceOfBirth: "YAMOUSSOUKRO, CÔTE D'IVOIRE",
    enrollmentCenter: "EPP Gnousso de Gagnoa",
    pollingStation: "CENTRE D'ENROLEMENT #142",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00187654",
    uniqueRegistrationNumber: "V 0215 0487 93",
    fullName: "DIALLO AMINATA",
    dateOfBirth: "23/09/1990",
    placeOfBirth: "DALOA, CÔTE D'IVOIRE",
    gender: "FÉMININ",
    profession: "MÉDECIN",
    residence: "COCODY, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "DIALLO MAMADOU",
    fatherDateOfBirth: "12/12/1960",
    fatherPlaceOfBirth: "SAN PEDRO, CÔTE D'IVOIRE",
    motherName: "KONÉ FATOU",
    motherDateOfBirth: "04/04/1965",
    motherPlaceOfBirth: "KORHOGO, CÔTE D'IVOIRE",
    enrollmentCenter: "Lycée Sainte Marie de Cocody",
    pollingStation: "CENTRE D'ENROLEMENT #078",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00256932",
    uniqueRegistrationNumber: "V 0317 0642 21",
    fullName: "BAMBA IBRAHIM",
    dateOfBirth: "07/11/1978",
    placeOfBirth: "KORHOGO, CÔTE D'IVOIRE",
    gender: "MASCULIN",
    profession: "ENSEIGNANT",
    residence: "YOPOUGON, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "BAMBA SOULEYMANE",
    fatherDateOfBirth: "20/06/1950",
    fatherPlaceOfBirth: "KORHOGO, CÔTE D'IVOIRE",
    motherName: "TOURÉ MARIAM",
    motherDateOfBirth: "15/03/1953",
    motherPlaceOfBirth: "BOUNDIALI, CÔTE D'IVOIRE",
    enrollmentCenter: "EPP Niangon Sud",
    pollingStation: "CENTRE D'ENROLEMENT #203",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00378541",
    uniqueRegistrationNumber: "V 0426 0798 35",
    fullName: "KONAN ANGÈLE SOPHIE",
    dateOfBirth: "16/02/1983",
    placeOfBirth: "BOUAKÉ, CÔTE D'IVOIRE",
    gender: "FÉMININ",
    profession: "AVOCATE",
    residence: "PLATEAU, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "KONAN PIERRE",
    fatherDateOfBirth: "09/09/1957",
    fatherPlaceOfBirth: "BOUAKÉ, CÔTE D'IVOIRE",
    motherName: "AKISSI JEANNE",
    motherDateOfBirth: "23/10/1960",
    motherPlaceOfBirth: "ABIDJAN, CÔTE D'IVOIRE",
    enrollmentCenter: "Collège Moderne Le Plateau",
    pollingStation: "CENTRE D'ENROLEMENT #056",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00462178",
    uniqueRegistrationNumber: "V 0535 0821 47",
    fullName: "OUATTARA KARIM",
    dateOfBirth: "30/07/1992",
    placeOfBirth: "KORHOGO, CÔTE D'IVOIRE",
    gender: "MASCULIN",
    profession: "INFORMATICIEN",
    residence: "PORT-BOUËT, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "OUATTARA AMADOU",
    fatherDateOfBirth: "14/02/1965",
    fatherPlaceOfBirth: "FERKESSÉDOUGOU, CÔTE D'IVOIRE",
    motherName: "SANOGO ROKIA",
    motherDateOfBirth: "01/05/1968",
    motherPlaceOfBirth: "KORHOGO, CÔTE D'IVOIRE",
    enrollmentCenter: "EPP Port-Bouët 2",
    pollingStation: "CENTRE D'ENROLEMENT #189",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00517693",
    uniqueRegistrationNumber: "V 0629 0935 74",
    fullName: "BAKAYOKO MARIAM",
    dateOfBirth: "19/12/1987",
    placeOfBirth: "MAN, CÔTE D'IVOIRE",
    gender: "FÉMININ",
    profession: "COMMERÇANTE",
    residence: "ADJAMÉ, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "BAKAYOKO ISSOUF",
    fatherDateOfBirth: "25/11/1958",
    fatherPlaceOfBirth: "MAN, CÔTE D'IVOIRE",
    motherName: "CISSÉ SALIMATA",
    motherDateOfBirth: "08/07/1963",
    motherPlaceOfBirth: "ODIENNÉ, CÔTE D'IVOIRE",
    enrollmentCenter: "EPP Adjamé Village",
    pollingStation: "CENTRE D'ENROLEMENT #112",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00623845",
    uniqueRegistrationNumber: "V 0738 1047 89",
    fullName: "KOFFI PAUL ÉMILE",
    dateOfBirth: "03/04/1975",
    placeOfBirth: "DIVO, CÔTE D'IVOIRE",
    gender: "MASCULIN",
    profession: "AGRONOME",
    residence: "BINGERVILLE, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "KOFFI KOUADIO",
    fatherDateOfBirth: "17/08/1948",
    fatherPlaceOfBirth: "DIVO, CÔTE D'IVOIRE",
    motherName: "AKOU MICHELLE",
    motherDateOfBirth: "12/06/1950",
    motherPlaceOfBirth: "ABOISSO, CÔTE D'IVOIRE",
    enrollmentCenter: "Groupe Scolaire Bingerville",
    pollingStation: "CENTRE D'ENROLEMENT #097",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00736921",
    uniqueRegistrationNumber: "V 0849 1152 36",
    fullName: "TRAORÉ FATOUMATA",
    dateOfBirth: "25/10/1980",
    placeOfBirth: "SÉGUÉLA, CÔTE D'IVOIRE",
    gender: "FÉMININ",
    profession: "INFIRMIÈRE",
    residence: "KOUMASSI, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "TRAORÉ SEYDOU",
    fatherDateOfBirth: "30/03/1952",
    fatherPlaceOfBirth: "SÉGUÉLA, CÔTE D'IVOIRE",
    motherName: "KONATÉ MAIMOUNA",
    motherDateOfBirth: "22/09/1955",
    motherPlaceOfBirth: "ODIENNÉ, CÔTE D'IVOIRE",
    enrollmentCenter: "EPP Koumassi Prodomo",
    pollingStation: "CENTRE D'ENROLEMENT #164",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00842765",
    uniqueRegistrationNumber: "V 0953 1269 42",
    fullName: "ASSALÉ ROBERT",
    dateOfBirth: "11/06/1979",
    placeOfBirth: "ABENGOUROU, CÔTE D'IVOIRE",
    gender: "MASCULIN",
    profession: "COMPTABLE",
    residence: "MARCORY, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "ASSALÉ JULES",
    fatherDateOfBirth: "02/12/1953",
    fatherPlaceOfBirth: "ABENGOUROU, CÔTE D'IVOIRE",
    motherName: "AHOU SUZANNE",
    motherDateOfBirth: "19/01/1956",
    motherPlaceOfBirth: "ABOISSO, CÔTE D'IVOIRE",
    enrollmentCenter: "Lycée Municipal de Marcory",
    pollingStation: "CENTRE D'ENROLEMENT #127",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),

  const ElectorVerificationResult(
    orderNumber: "00953814",
    uniqueRegistrationNumber: "V 1064 1375 57",
    fullName: "YAO CHRISTINE",
    dateOfBirth: "08/03/1994",
    placeOfBirth: "ABIDJAN, CÔTE D'IVOIRE",
    gender: "FÉMININ",
    profession: "ÉTUDIANTE",
    residence: "TREICHVILLE, ABIDJAN, CÔTE D'IVOIRE",
    fatherName: "YAO BERNARD",
    fatherDateOfBirth: "27/05/1967",
    fatherPlaceOfBirth: "BONGOUANOU, CÔTE D'IVOIRE",
    motherName: "N'GUESSAN SOLANGE",
    motherDateOfBirth: "14/11/1970",
    motherPlaceOfBirth: "DIMBOKRO, CÔTE D'IVOIRE",
    enrollmentCenter: "EPP Treichville Centre",
    pollingStation: "CENTRE D'ENROLEMENT #092",
    voterStatus: "INSCRIT",
    imageUrl: AssetConstants.user,
  ),
];

class ElectorVerificationResult {
  final String orderNumber;
  final String uniqueRegistrationNumber;
  final String fullName;
  final String dateOfBirth;
  final String placeOfBirth;
  final String gender;
  final String profession;
  final String residence;
  final String fatherName;
  final String fatherDateOfBirth;
  final String fatherPlaceOfBirth;
  final String motherName;
  final String motherDateOfBirth;
  final String motherPlaceOfBirth;
  final String enrollmentCenter;
  final String pollingStation;
  final String voterStatus;
  final String imageUrl;

  const ElectorVerificationResult({
    this.orderNumber = "00145823",
    this.uniqueRegistrationNumber = "V 0104 0305 68",
    this.fullName = "KOUASSI JEAN MARC",
    this.dateOfBirth = "12/05/1985",
    this.placeOfBirth = "ABIDJAN,CÔTE D'IVOIRE",
    this.gender = "MASCULIN",
    this.profession = "INGÉNIEUR",
    this.residence = "ABOBO, ABIDJAN, CÔTE D'IVOIRE",
    this.fatherName = "KOUASSI EMMANUEL",
    this.fatherDateOfBirth = "05/03/1955",
    this.fatherPlaceOfBirth = "BOUAKÉ, CÔTE D'IVOIRE",
    this.motherName = "YAPI MARIE CLAIRE",
    this.motherDateOfBirth = "17/08/1957",
    this.motherPlaceOfBirth = "YAMOUSSOUKRO, CÔTE D'IVOIRE",
    this.enrollmentCenter = "EPP Gnousso de Gagnoa",
    this.pollingStation = "CENTRE D'ENROLEMENT #142",
    this.voterStatus = "INSCRIT",
    this.imageUrl = AssetConstants.user,
  });

  // Optionally, you can add a fromJson factory constructor
  factory ElectorVerificationResult.fromJson(Map<String, dynamic> json) {
    return ElectorVerificationResult(
      orderNumber: json['orderNumber'] ?? "00145823",
      uniqueRegistrationNumber:
      json['uniqueRegistrationNumber'] ?? "V 0104 0305 68",
      fullName: json['fullName'] ?? "KOUASSI JEAN MARC",
      dateOfBirth: json['dateOfBirth'] ?? "12/05/1985",
      placeOfBirth: json['placeOfBirth'] ?? "ABIDJAN, CÔTE D'IVOIRE",
      gender: json['gender'] ?? "MASCULIN",
      profession: json['profession'] ?? "INGÉNIEUR",
      residence: json['residence'] ?? "ABOBO, ABIDJAN, CÔTE D'IVOIRE",
      fatherName: json['fatherName'] ?? "KOUASSI EMMANUEL",
      fatherDateOfBirth: json['fatherDateOfBirth'] ?? "05/03/1955",
      fatherPlaceOfBirth: json['fatherPlaceOfBirth'] ?? "BOUAKÉ, CÔTE D'IVOIRE",
      motherName: json['motherName'] ?? "YAPI MARIE CLAIRE",
      motherDateOfBirth: json['motherDateOfBirth'] ?? "17/08/1957",
      motherPlaceOfBirth: json['motherPlaceOfBirth'] ?? "YAMOUSSOUKRO",
      enrollmentCenter:
      json['enrollmentCenter'] ?? "ÉCOLE PRIMAIRE PUBLIQUE D'ABOBO",
      pollingStation: json['pollingStation'] ?? "CENTRE D'ENROLEMENT #142",
      voterStatus: json['voterStatus'] ?? "INSCRIT",
      imageUrl: json['imageUrl'] ?? AssetConstants.user,
    );
  }

  // Optionally, you can add a toJson method
  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'uniqueRegistrationNumber': uniqueRegistrationNumber,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'placeOfBirth': placeOfBirth,
      'gender': gender,
      'profession': profession,
      'residence': residence,
      'fatherName': fatherName,
      'fatherDateOfBirth': fatherDateOfBirth,
      'fatherPlaceOfBirth': fatherPlaceOfBirth,
      'motherName': motherName,
      'motherDateOfBirth': motherDateOfBirth,
      'motherPlaceOfBirth': motherPlaceOfBirth,
      'enrollmentCenter': enrollmentCenter,
      'pollingStation': pollingStation,
      'voterStatus': voterStatus,
      'imageUrl': imageUrl,
    };
  }
}



final Map<String, List<String>> citiesAndCommunes = {
  'Abidjan': [
    'Abobo',
    'Adjamé',
    'Attécoubé',
    'Cocody',
    'Koumassi',
    'Marcory',
    'Plateau',
    'Port-Bouët',
    'Treichville',
    'Yopougon',
    'Bingerville',
    'Songon',
  ],
  'Bouaké': [

  ],
  'Daloa': [

  ],
  'Yamoussoukro': [

  ],
  'San-Pédro': [

  ],
  'Korhogo': [

  ],
  'Man': [

  ],
  'Gagnoa': [

  ],
  'Divo': [

  ],
  'Abengourou': [

  ],
  'Aboisso': [],
  'Adzopé': [],
  'Agboville': [],
  'Akoupé': [],
  'Alépé': [],
  'Anyama': [],
  'Bassam': [],
  'Bondoukou': [],
  'Bongouanou': [],
  'Bouaflé': [],
  'Dabou': [],
  'Daoukro': [],
  'Dimbokro': [],
  'Ferkessédougou': [],
  'Guiglo': [],
  'Issia': [],
  'Jacqueville': [],
  'Katiola': [],
  'Lakota': [],
  'Mankono': [],
  'Odienné': [],
  'Oumé': [],
  'Sassandra': [],
  'Séguéla': [],
  'Sinfra': [],
  'Soubré': [],
  'Tiassalé': [],
  'Touba': [],
  'Toumodi': [],
  'Vavoua': [],
};

Future<void> openFile(String path) async {
  try {
    await OpenFilex.open(path);
  } catch (e) {
    debugPrint('Error opening file: $e');
  }
}
