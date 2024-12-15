import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:my_app/features/patient/patient_viewmodel.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/utils/date_formatter.dart';
import 'package:my_app/shared/widgets/custom_button.dart';

class PatientDetailsView extends StackedView<PatientViewModel> {
  final Map<String, dynamic> patient;

  const PatientDetailsView({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Patient Details', style: TextStyles.h2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: AppColors.error,
            onPressed: () => viewModel.deletePatient(patient['id']),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (viewModel.modelError != null)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  viewModel.modelError.toString(),
                  style: TextStyles.body2.copyWith(color: AppColors.error),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      patient['name'][0].toUpperCase(),
                      style: TextStyles.h1.copyWith(color: AppColors.primary),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    patient['name'],
                    style: TextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(8),
                  Text(
                    'ID: ${patient['id']}',
                    style: TextStyles.caption,
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoChip(
                        Icons.cake_outlined,
                        DateFormatter.formatAgeFromBirthDate(
                          DateTime.parse(patient['dateOfBirth']),
                        ),
                      ),
                      _buildInfoChip(
                        Icons.person_outline,
                        patient['gender'],
                      ),
                      _buildInfoChip(
                        Icons.phone_outlined,
                        patient['phone'],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('Email', patient['email'] ?? 'Not provided'),
                  const Gap(16),
                  _buildSection('Address', patient['address']),
                  const Gap(16),
                  _buildSection(
                    'Medical History',
                    patient['medicalHistory'] ?? 'No medical history recorded',
                  ),
                  const Gap(16),
                  _buildSection(
                    'Allergies',
                    patient['allergies'] ?? 'No allergies recorded',
                  ),
                  const Gap(24),
                  CustomButton(
                    text: 'View Diagnoses',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/diagnosis-list',
                      arguments: {
                        'patientId': patient['id'],
                        'patientName': patient['name'],
                      },
                    ),
                    icon: Icons.medical_services_outlined,
                  ),
                  const Gap(16),
                  CustomButton(
                    text: 'Add New Diagnosis',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/add-diagnosis',
                      arguments: {
                        'patientId': patient['id'],
                        'patientName': patient['name'],
                      },
                    ),
                    backgroundColor: AppColors.secondary,
                    icon: Icons.add_circle_outline,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyles.body2.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.caption,
        ),
        const Gap(4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            content,
            style: TextStyles.body1,
          ),
        ),
      ],
    );
  }

  @override
  PatientViewModel viewModelBuilder(BuildContext context) => PatientViewModel(
        context.findAncestorWidgetOfExactType<PatientRepository>()!,
        context.findAncestorWidgetOfExactType<NavigationService>()!,
        context.findAncestorWidgetOfExactType<DialogService>()!,
      );
}
