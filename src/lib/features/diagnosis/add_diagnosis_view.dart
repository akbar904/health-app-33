import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:my_app/features/diagnosis/diagnosis_viewmodel.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/widgets/custom_text_field.dart';
import 'package:my_app/shared/widgets/custom_button.dart';

class AddDiagnosisView extends StackedView<DiagnosisViewModel> {
  final String patientId;
  final String patientName;

  const AddDiagnosisView({
    Key? key,
    required this.patientId,
    required this.patientName,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DiagnosisViewModel viewModel,
    Widget? child,
  ) {
    final symptomsController = TextEditingController();
    final diagnosisController = TextEditingController();
    final treatmentController = TextEditingController();
    final prescriptionController = TextEditingController();
    final notesController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Diagnosis', style: TextStyles.h2),
            Text(
              patientName,
              style: TextStyles.body2.copyWith(color: AppColors.textLight),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (viewModel.modelError != null)
              Container(
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
            const Gap(16),
            CustomTextField(
              controller: symptomsController,
              label: 'Symptoms',
              hint: 'Enter patient symptoms',
              maxLines: 3,
              isRequired: true,
              prefixIcon: Icons.sick_outlined,
            ),
            const Gap(16),
            CustomTextField(
              controller: diagnosisController,
              label: 'Diagnosis',
              hint: 'Enter diagnosis',
              maxLines: 3,
              isRequired: true,
              prefixIcon: Icons.medical_services_outlined,
            ),
            const Gap(16),
            CustomTextField(
              controller: treatmentController,
              label: 'Treatment Plan',
              hint: 'Enter treatment plan',
              maxLines: 3,
              isRequired: true,
              prefixIcon: Icons.healing_outlined,
            ),
            const Gap(16),
            CustomTextField(
              controller: prescriptionController,
              label: 'Prescription',
              hint: 'Enter prescription details',
              maxLines: 3,
              isRequired: true,
              prefixIcon: Icons.medication_outlined,
            ),
            const Gap(16),
            CustomTextField(
              controller: notesController,
              label: 'Additional Notes',
              hint: 'Enter any additional notes',
              maxLines: 3,
              prefixIcon: Icons.note_outlined,
            ),
            const Gap(24),
            CustomButton(
              text: 'Save Diagnosis',
              onPressed: () {
                if (symptomsController.text.isEmpty ||
                    diagnosisController.text.isEmpty ||
                    treatmentController.text.isEmpty ||
                    prescriptionController.text.isEmpty) {
                  viewModel.setError('Please fill in all required fields');
                  return;
                }

                viewModel.createDiagnosis(
                  symptoms: symptomsController.text,
                  diagnosis: diagnosisController.text,
                  treatment: treatmentController.text,
                  prescription: prescriptionController.text,
                  notes: notesController.text.isEmpty
                      ? null
                      : notesController.text,
                );
              },
              isLoading: viewModel.isBusy,
            ),
          ],
        ),
      ),
    );
  }

  @override
  DiagnosisViewModel viewModelBuilder(BuildContext context) {
    final viewModel = DiagnosisViewModel(
      context.findAncestorWidgetOfExactType<DiagnosisRepository>()!,
      context.findAncestorWidgetOfExactType<NavigationService>()!,
      context.findAncestorWidgetOfExactType<DialogService>()!,
    );
    viewModel.setCurrentPatientId(patientId);
    return viewModel;
  }
}
