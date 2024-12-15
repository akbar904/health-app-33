import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:my_app/features/diagnosis/diagnosis_viewmodel.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/utils/date_formatter.dart';

class DiagnosisDetailsView extends StackedView<DiagnosisViewModel> {
  final Map<String, dynamic> diagnosis;

  const DiagnosisDetailsView({
    Key? key,
    required this.diagnosis,
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
        title: Text('Diagnosis Details', style: TextStyles.h2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: AppColors.error,
            onPressed: () => viewModel.deleteDiagnosis(diagnosis['id']),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyles.caption,
                        ),
                        Text(
                          DateFormatter.formatDateTime(
                            DateTime.parse(diagnosis['createdAt']),
                          ),
                          style: TextStyles.body2.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    _buildSection('Symptoms', diagnosis['symptoms']),
                    const Gap(16),
                    _buildSection('Diagnosis', diagnosis['diagnosis']),
                    const Gap(16),
                    _buildSection('Treatment', diagnosis['treatment']),
                    const Gap(16),
                    _buildSection('Prescription', diagnosis['prescription']),
                    if (diagnosis['notes'] != null) ...[
                      const Gap(16),
                      _buildSection('Notes', diagnosis['notes']),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
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
        Text(
          content,
          style: TextStyles.body1,
        ),
      ],
    );
  }

  @override
  DiagnosisViewModel viewModelBuilder(BuildContext context) =>
      DiagnosisViewModel(
        context.findAncestorWidgetOfExactType<DiagnosisRepository>()!,
        context.findAncestorWidgetOfExactType<NavigationService>()!,
        context.findAncestorWidgetOfExactType<DialogService>()!,
      );
}
