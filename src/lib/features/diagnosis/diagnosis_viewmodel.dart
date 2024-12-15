import 'package:stacked/stacked.dart';
import 'package:my_app/features/diagnosis/diagnosis_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class DiagnosisViewModel extends BaseViewModel {
  final DiagnosisRepository _diagnosisRepository;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  DiagnosisViewModel(
    this._diagnosisRepository,
    this._navigationService,
    this._dialogService,
  );

  List<Map<String, dynamic>> _diagnoses = [];
  Map<String, dynamic>? _selectedDiagnosis;
  String? _currentPatientId;
  String? _modelError;

  List<Map<String, dynamic>> get diagnoses => _diagnoses;
  Map<String, dynamic>? get selectedDiagnosis => _selectedDiagnosis;
  String? get currentPatientId => _currentPatientId;
  String? get modelError => _modelError;

  void setCurrentPatientId(String patientId) {
    _currentPatientId = patientId;
    loadDiagnoses();
  }

  Future<void> loadDiagnoses() async {
    try {
      setBusy(true);
      _modelError = null;
      _diagnoses = await _diagnosisRepository.listDiagnoses(
        patientId: _currentPatientId,
      );
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> createDiagnosis({
    required String symptoms,
    required String diagnosis,
    required String treatment,
    required String prescription,
    String? notes,
  }) async {
    try {
      setBusy(true);
      _modelError = null;
      if (_currentPatientId == null) {
        throw Exception('No patient selected for diagnosis');
      }
      await _diagnosisRepository.createDiagnosis(
        patientId: _currentPatientId!,
        symptoms: symptoms,
        diagnosis: diagnosis,
        treatment: treatment,
        prescription: prescription,
        notes: notes,
      );
      await loadDiagnoses();
      await _navigationService.back();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> getDiagnosis(String diagnosisId) async {
    try {
      setBusy(true);
      _modelError = null;
      _selectedDiagnosis = await _diagnosisRepository.getDiagnosis(diagnosisId);
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> updateDiagnosis(
    String diagnosisId,
    Map<String, dynamic> updates,
  ) async {
    try {
      setBusy(true);
      _modelError = null;
      await _diagnosisRepository.updateDiagnosis(diagnosisId, updates);
      await loadDiagnoses();
      await _navigationService.back();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> deleteDiagnosis(String diagnosisId) async {
    try {
      setBusy(true);
      _modelError = null;
      final dialogResponse = await _dialogService.showDialog(
        title: 'Delete Diagnosis',
        description: 'Are you sure you want to delete this diagnosis record?',
        buttonTitle: 'Delete',
        cancelTitle: 'Cancel',
      );

      if (dialogResponse?.confirmed ?? false) {
        await _diagnosisRepository.deleteDiagnosis(diagnosisId);
        await loadDiagnoses();
        await _navigationService.back();
      }
    } catch (e) {
      _modelError = e.toString();
      await _dialogService.showDialog(
        title: 'Error',
        description: _modelError,
      );
    } finally {
      setBusy(false);
    }
  }
}
