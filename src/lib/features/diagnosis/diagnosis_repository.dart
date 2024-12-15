import 'package:my_app/services/diagnosis_service.dart';

class DiagnosisRepository {
  final DiagnosisService _diagnosisService;

  DiagnosisRepository(this._diagnosisService);

  Future<Map<String, dynamic>> createDiagnosis({
    required String patientId,
    required String symptoms,
    required String diagnosis,
    required String treatment,
    required String prescription,
    String? notes,
  }) async {
    try {
      final diagnosisData = {
        'patientId': patientId,
        'symptoms': symptoms,
        'diagnosis': diagnosis,
        'treatment': treatment,
        'prescription': prescription,
        'notes': notes,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      return await _diagnosisService.createDiagnosis(diagnosisData);
    } catch (e) {
      throw Exception('Unable to create diagnosis record. Please try again.');
    }
  }

  Future<Map<String, dynamic>> getDiagnosis(String diagnosisId) async {
    try {
      return await _diagnosisService.getDiagnosis(diagnosisId);
    } catch (e) {
      throw Exception('Unable to fetch diagnosis details. Please try again.');
    }
  }

  Future<List<Map<String, dynamic>>> listDiagnoses({String? patientId}) async {
    try {
      return await _diagnosisService.listDiagnoses(patientId: patientId);
    } catch (e) {
      throw Exception('Unable to load diagnosis list. Please try again.');
    }
  }

  Future<Map<String, dynamic>> updateDiagnosis(
    String diagnosisId,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updatedAt'] = DateTime.now().toIso8601String();
      return await _diagnosisService.updateDiagnosis(diagnosisId, updates);
    } catch (e) {
      throw Exception('Unable to update diagnosis record. Please try again.');
    }
  }

  Future<void> deleteDiagnosis(String diagnosisId) async {
    try {
      await _diagnosisService.deleteDiagnosis(diagnosisId);
    } catch (e) {
      throw Exception('Unable to delete diagnosis record. Please try again.');
    }
  }
}
