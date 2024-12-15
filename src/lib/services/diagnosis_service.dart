import 'package:my_app/services/appwrite_service.dart';
import 'package:stacked/stacked.dart';

class DiagnosisService implements InitializableDependency {
  final AppwriteService _appwriteService;

  DiagnosisService(this._appwriteService);

  @override
  Future<void> init() async {
    // Initialize any required diagnosis service state
  }

  Future<Map<String, dynamic>> createDiagnosis(
      Map<String, dynamic> diagnosisData) async {
    try {
      final response = await _appwriteService.createDocument(
        AppwriteService.diagnosisCollectionId,
        diagnosisData,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to create diagnosis record. Please try again.');
    }
  }

  Future<Map<String, dynamic>> getDiagnosis(String diagnosisId) async {
    try {
      final response = await _appwriteService.getDocument(
        AppwriteService.diagnosisCollectionId,
        diagnosisId,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch diagnosis details. Please try again.');
    }
  }

  Future<List<Map<String, dynamic>>> listDiagnoses({String? patientId}) async {
    try {
      final queries = patientId != null ? ['patientId=$patientId'] : null;
      final response = await _appwriteService.listDocuments(
        AppwriteService.diagnosisCollectionId,
        queries: queries,
      );
      return response.documents.map((doc) => doc.data).toList();
    } catch (e) {
      throw Exception('Failed to load diagnosis list. Please try again.');
    }
  }

  Future<Map<String, dynamic>> updateDiagnosis(
    String diagnosisId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await _appwriteService.updateDocument(
        AppwriteService.diagnosisCollectionId,
        diagnosisId,
        updates,
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to update diagnosis record. Please try again.');
    }
  }

  Future<void> deleteDiagnosis(String diagnosisId) async {
    try {
      await _appwriteService.deleteDocument(
        AppwriteService.diagnosisCollectionId,
        diagnosisId,
      );
    } catch (e) {
      throw Exception('Failed to delete diagnosis record. Please try again.');
    }
  }
}
