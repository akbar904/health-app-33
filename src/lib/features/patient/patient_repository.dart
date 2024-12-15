import 'package:my_app/services/patient_service.dart';

class PatientRepository {
  final PatientService _patientService;

  PatientRepository(this._patientService);

  Future<Map<String, dynamic>> createPatient({
    required String name,
    required DateTime dateOfBirth,
    required String gender,
    required String address,
    required String phone,
    String? email,
    String? medicalHistory,
    String? allergies,
  }) async {
    try {
      final patientData = {
        'name': name,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'address': address,
        'phone': phone,
        'email': email,
        'medicalHistory': medicalHistory,
        'allergies': allergies,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      return await _patientService.createPatient(patientData);
    } catch (e) {
      throw Exception('Unable to create patient record. Please try again.');
    }
  }

  Future<Map<String, dynamic>> getPatient(String patientId) async {
    try {
      return await _patientService.getPatient(patientId);
    } catch (e) {
      throw Exception('Unable to fetch patient details. Please try again.');
    }
  }

  Future<List<Map<String, dynamic>>> listPatients() async {
    try {
      return await _patientService.listPatients();
    } catch (e) {
      throw Exception(
          'Unable to load patient list. Please check your connection.');
    }
  }

  Future<Map<String, dynamic>> updatePatient(
    String patientId,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updatedAt'] = DateTime.now().toIso8601String();
      return await _patientService.updatePatient(patientId, updates);
    } catch (e) {
      throw Exception(
          'Unable to update patient information. Please try again.');
    }
  }

  Future<void> deletePatient(String patientId) async {
    try {
      await _patientService.deletePatient(patientId);
    } catch (e) {
      throw Exception('Unable to delete patient record. Please try again.');
    }
  }

  Future<List<Map<String, dynamic>>> searchPatients(String query) async {
    try {
      if (query.isEmpty) {
        return await listPatients();
      }
      return await _patientService.searchPatients(query);
    } catch (e) {
      throw Exception('Unable to search patients. Please try again.');
    }
  }
}
