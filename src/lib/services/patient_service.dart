import 'package:my_app/services/appwrite_service.dart';
import 'package:stacked/stacked.dart';

class PatientService implements InitializableDependency {
  final AppwriteService _appwriteService;

  PatientService(this._appwriteService);

  @override
  Future<void> init() async {
    // Initialize any required patient service state
  }

  Future<Map<String, dynamic>> createPatient(
      Map<String, dynamic> patientData) async {
    try {
      final response = await _appwriteService.createDocument(
        AppwriteService.patientsCollectionId,
        patientData,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create patient record. Please try again.');
    }
  }

  Future<Map<String, dynamic>> getPatient(String patientId) async {
    try {
      final response = await _appwriteService.getDocument(
        AppwriteService.patientsCollectionId,
        patientId,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch patient details. Please try again.');
    }
  }

  Future<List<Map<String, dynamic>>> listPatients() async {
    try {
      final response = await _appwriteService.listDocuments(
        AppwriteService.patientsCollectionId,
      );
      return response.documents.map((doc) => doc.data).toList();
    } catch (e) {
      throw Exception(
          'Failed to load patient list. Please check your connection and try again.');
    }
  }

  Future<Map<String, dynamic>> updatePatient(
    String patientId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await _appwriteService.updateDocument(
        AppwriteService.patientsCollectionId,
        patientId,
        updates,
      );
      return response.data;
    } catch (e) {
      throw Exception(
          'Failed to update patient information. Please try again.');
    }
  }

  Future<void> deletePatient(String patientId) async {
    try {
      await _appwriteService.deleteDocument(
        AppwriteService.patientsCollectionId,
        patientId,
      );
    } catch (e) {
      throw Exception('Failed to delete patient record. Please try again.');
    }
  }

  Future<List<Map<String, dynamic>>> searchPatients(String query) async {
    try {
      final response = await _appwriteService.listDocuments(
        AppwriteService.patientsCollectionId,
        queries: [
          'name.contains("$query")',
          'id.contains("$query")',
        ],
      );
      return response.documents.map((doc) => doc.data).toList();
    } catch (e) {
      throw Exception('Failed to search patients. Please try again.');
    }
  }
}
