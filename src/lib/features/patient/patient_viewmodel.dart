import 'package:stacked/stacked.dart';
import 'package:my_app/features/patient/patient_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class PatientViewModel extends BaseViewModel {
  final PatientRepository _patientRepository;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  PatientViewModel(
    this._patientRepository,
    this._navigationService,
    this._dialogService,
  );

  List<Map<String, dynamic>> _patients = [];
  Map<String, dynamic>? _selectedPatient;
  String? _searchQuery;
  String? _modelError;

  List<Map<String, dynamic>> get patients => _patients;
  Map<String, dynamic>? get selectedPatient => _selectedPatient;
  String? get searchQuery => _searchQuery;
  String? get modelError => _modelError;

  Future<void> loadPatients() async {
    try {
      setBusy(true);
      _modelError = null;
      _patients = await _patientRepository.listPatients();
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> searchPatients(String query) async {
    try {
      setBusy(true);
      _modelError = null;
      _searchQuery = query;
      _patients = await _patientRepository.searchPatients(query);
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> selectPatient(String patientId) async {
    try {
      setBusy(true);
      _modelError = null;
      _selectedPatient = await _patientRepository.getPatient(patientId);
      notifyListeners();
      await _navigationService.navigateTo(
        '/patient-details',
        arguments: _selectedPatient,
      );
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

  Future<void> createPatient({
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
      setBusy(true);
      _modelError = null;
      await _patientRepository.createPatient(
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
        address: address,
        phone: phone,
        email: email,
        medicalHistory: medicalHistory,
        allergies: allergies,
      );
      await loadPatients();
      await _navigationService.back();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> updatePatient(
    String patientId,
    Map<String, dynamic> updates,
  ) async {
    try {
      setBusy(true);
      _modelError = null;
      await _patientRepository.updatePatient(patientId, updates);
      await loadPatients();
      await _navigationService.back();
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> deletePatient(String patientId) async {
    try {
      setBusy(true);
      _modelError = null;
      final dialogResponse = await _dialogService.showDialog(
        title: 'Delete Patient',
        description: 'Are you sure you want to delete this patient record?',
        buttonTitle: 'Delete',
        cancelTitle: 'Cancel',
      );

      if (dialogResponse?.confirmed ?? false) {
        await _patientRepository.deletePatient(patientId);
        await loadPatients();
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
