import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:my_app/features/patient/patient_viewmodel.dart';
import 'package:my_app/shared/widgets/patient_card.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/widgets/custom_text_field.dart';

class PatientListView extends StackedView<PatientViewModel> {
  const PatientListView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Patients', style: TextStyles.h2),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              label: 'Search Patients',
              hint: 'Search by name or ID',
              prefixIcon: Icons.search,
              onChanged: viewModel.searchPatients,
            ),
          ),
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
                : viewModel.patients.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_search,
                              size: 64,
                              color: AppColors.textLight,
                            ),
                            const Gap(16),
                            Text(
                              'No patients found',
                              style: TextStyles.body1.copyWith(
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: viewModel.loadPatients,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: viewModel.patients.length,
                          separatorBuilder: (context, index) => const Gap(12),
                          itemBuilder: (context, index) {
                            final patient = viewModel.patients[index];
                            return PatientCard(
                              name: patient['name'],
                              id: patient['id'],
                              dateOfBirth:
                                  DateTime.parse(patient['dateOfBirth']),
                              gender: patient['gender'],
                              lastVisit: patient['lastVisit'],
                              onTap: () =>
                                  viewModel.selectPatient(patient['id']),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-patient'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  PatientViewModel viewModelBuilder(BuildContext context) => PatientViewModel(
        context.findAncestorWidgetOfExactType<PatientRepository>()!,
        context.findAncestorWidgetOfExactType<NavigationService>()!,
        context.findAncestorWidgetOfExactType<DialogService>()!,
      );

  @override
  void onViewModelReady(PatientViewModel viewModel) => viewModel.loadPatients();
}
