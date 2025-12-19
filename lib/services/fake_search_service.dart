import 'dart:math';
import 'package:cei_mobile/model/user/user_model.dart';

// Fake data for mock user search results
final List<Map<String, dynamic>> mockUsers = [
  {
    "id": "12345",
    "firstName": "Jean",
    "lastName": "Dupont",
    "uniqueRegistrationNumber": "V1234567890",
    "orderNumber": "A12345",
    "gender": "Masculin",
    "dateOfBirth": DateTime(1985, 5, 15),
    "nationality": "Ivoirienne",
    "profession": "Enseignant",
    "city": "Abidjan",
    "commune": "Cocody",
    "quarter": "Angré",
    "imageUrl": null,
    "pollingStation": {
      "id": "PS001",
      "name": "École Primaire Cocody",
      "centre": {
        "id": "C001",
        "name": "Centre de Vote Cocody"
      }
    }
  },
  {
    "id": "12346",
    "firstName": "Marie",
    "lastName": "Koné",
    "uniqueRegistrationNumber": "V2345678901",
    "orderNumber": "B54321",
    "gender": "Féminin",
    "dateOfBirth": DateTime(1990, 8, 22),
    "nationality": "Ivoirienne",
    "profession": "Médecin",
    "city": "Abidjan",
    "commune": "Yopougon",
    "quarter": "Selmer",
    "imageUrl": null,
    "pollingStation": {
      "id": "PS002",
      "name": "École Primaire Yopougon",
      "centre": {
        "id": "C002",
        "name": "Centre de Vote Yopougon"
      }
    }
  },
  {
    "id": "12347",
    "firstName": "Ahmed",
    "lastName": "Diallo",
    "uniqueRegistrationNumber": "V3456789012",
    "orderNumber": "C67890",
    "gender": "Masculin",
    "dateOfBirth": DateTime(1975, 12, 3),
    "nationality": "Ivoirienne",
    "profession": "Commerçant",
    "city": "Bouaké",
    "commune": "Centre",
    "quarter": "Commerce",
    "imageUrl": null,
    "pollingStation": {
      "id": "PS003",
      "name": "Lycée Municipal",
      "centre": {
        "id": "C003",
        "name": "Centre de Vote Bouaké"
      }
    }
  },
  {
    "id": "12348",
    "firstName": "Fatou",
    "lastName": "Touré",
    "uniqueRegistrationNumber": "V4567890123",
    "orderNumber": "D13579",
    "gender": "Féminin",
    "dateOfBirth": DateTime(1982, 3, 28),
    "nationality": "Ivoirienne",
    "profession": "Avocate",
    "city": "Korhogo",
    "commune": "Centre",
    "quarter": "Résidentiel",
    "imageUrl": null,
    "pollingStation": {
      "id": "PS004",
      "name": "École Primaire Centre",
      "centre": {
        "id": "C004",
        "name": "Centre de Vote Korhogo"
      }
    }
  },
  {
    "id": "12349",
    "firstName": "Paul",
    "lastName": "Kouassi",
    "uniqueRegistrationNumber": "V5678901234",
    "orderNumber": "E24680",
    "gender": "Masculin",
    "dateOfBirth": DateTime(1968, 7, 10),
    "nationality": "Ivoirienne",
    "profession": "Fonctionnaire",
    "city": "Yamoussoukro",
    "commune": "Centre",
    "quarter": "Présidentiel",
    "imageUrl": null,
    "pollingStation": {
      "id": "PS005",
      "name": "Centre Culturel",
      "centre": {
        "id": "C005",
        "name": "Centre de Vote Yamoussoukro"
      }
    }
  }
];

// Test credentials for verification checks
final Map<String, String> testCredentials = {
  'form_number': '1234567890',
  'voter_id': 'V1234567890',
  'lastname': 'Dupont',
  'firstname': 'Jean',
  'dob_day': '15',
  'dob_month': '5',
  'dob_year': '1985',
};

class FakeSearchService {
  // Simulate a delay to mimic network request
  static Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: 800 + Random().nextInt(500)));
  }

  // Randomly decide if search will succeed or fail (80% success rate)
  static bool _shouldSearchSucceed() {
    return Random().nextDouble() < 0.8; // 80% success rate
  }

  // Search by form number
  static Future<Map<String, dynamic>> searchByFormNumber(String formNumber) async {
    await _simulateNetworkDelay();

    // If the form number exactly matches the test credential, always return first user
    if (formNumber == testCredentials['form_number']) {
      return {'success': true, 'data': mockUsers[0]};
    }

    // Otherwise apply random success/fail logic
    if (_shouldSearchSucceed()) {
      // Return a random user from the mock data
      final user = mockUsers[Random().nextInt(mockUsers.length)];
      return {'success': true, 'data': user};
    } else {
      throw "Aucun électeur trouvé avec ce numéro de formulaire. Veuillez vérifier vos informations.";
    }
  }

  // Search by voter ID
  static Future<Map<String, dynamic>> searchByVoterId(String voterId) async {
    await _simulateNetworkDelay();

    // Clean voter ID by removing spaces
    final cleanVoterId = voterId.replaceAll(' ', '');

    // If the voter ID exactly matches the test credential, always return first user
    if (cleanVoterId == testCredentials['voter_id']) {
      return {'success': true, 'data': mockUsers[0]};
    }

    // Otherwise apply random success/fail logic
    if (_shouldSearchSucceed()) {
      // Return a random user from the mock data
      final user = mockUsers[Random().nextInt(mockUsers.length)];
      return {'success': true, 'data': user};
    } else {
      throw "Aucun électeur trouvé avec ce numéro d'électeur. Veuillez vérifier vos informations.";
    }
  }

  // Search by name and birthdate
  static Future<Map<String, dynamic>> searchByNameAndBirthdate(
      String firstName,
      String lastName,
      String birthdate
      ) async {
    await _simulateNetworkDelay();

    // Parse birthdate
    final parts = birthdate.split('-');
    final year = parts[0];
    final month = parts[1];
    final day = parts[2];

    // If name and birthdate exactly match the test credentials, always return first user
    if (firstName.toLowerCase() == testCredentials['firstname']!.toLowerCase() &&
        lastName.toLowerCase() == testCredentials['lastname']!.toLowerCase() &&
        day == testCredentials['dob_day'] &&
        month == testCredentials['dob_month'] &&
        year == testCredentials['dob_year']) {
      return {'success': true, 'data': mockUsers[0]};
    }

    // Otherwise apply random success/fail logic
    if (_shouldSearchSucceed()) {
      // Return a random user from the mock data
      final user = mockUsers[Random().nextInt(mockUsers.length)];
      return {'success': true, 'data': user};
    } else {
      throw "Aucun électeur trouvé avec ces informations. Veuillez vérifier votre nom, prénom et date de naissance.";
    }
  }
}