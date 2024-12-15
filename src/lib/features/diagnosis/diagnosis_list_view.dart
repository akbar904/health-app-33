import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:my_app/features/diagnosis/diagnosis_viewmodel.dart';
import 'package:my_app/shared/widgets/diagnosis_card.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';

class DiagnosisListView extends StackedView<DiagnosisViewModel> {
  final String patientId;
  final String patientName;

  const DiagnosisListView({
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Diagnoses', style: TextStyles.h2),
            Text(
              patientName,
              style: TextStyles.body2.copyWith(color: AppColors.textLight),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          if (viewModel.modelError != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
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
            ),
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : viewModel.diagnoses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.medical_information_outlined,
                              size: 64,
                              color: AppColors.textLight,
                            ),
                            const Gap(16),
                            Text(
                              'No diagnoses found',
                              style: TextStyles.body1.copyWith(
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: viewModel.loadDiagnoses,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: viewModel.diagnoses.length,
                          separatorBuilder: (context, index) => const Gap(12),
                          itemBuilder: (context, index) {
                            final diagnosis = viewModel.diagnoses[index];
                            return DiagnosisCard(
                              diagnosis: diagnosis['diagnosis'],
                              symptoms: diagnosis['symptoms'],
                              treatment: diagnosis['treatment'],
                              date: DateTime.parse(diagnosis['createdAt']),
                              onTap: () =>
                                  viewModel.getDiagnosis(diagnosis['id']),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          '/add-diagnosis',
          arguments: {
            'patientId': patientId,
            'patientName': patientName,
          },
        ),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
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

  @override
  void onViewModelReady(DiagnosisViewModel viewModel) =>
      viewModel.loadDiagnoses();
}
