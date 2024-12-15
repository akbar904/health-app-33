import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:gap/gap.dart';
import 'package:my_app/features/patient/patient_viewmodel.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/widgets/custom_text_field.dart';
import 'package:my_app/shared/widgets/custom_button.dart';

class AddPatientView extends StackedView<PatientViewModel> {
  const AddPatientView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PatientViewModel viewModel,
    Widget? child,
  ) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final medicalHistoryController = TextEditingController();
    final allergiesController = TextEditingController();
    DateTime? selectedDate;
    String? selectedGender;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Add New Patient', style: TextStyles.h2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
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
              controller: nameController,
              label: 'Full Name',
              hint: 'Enter patient\'s full name',
              prefixIcon: Icons.person_outline,
              isRequired: true,
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: selectedDate == null
                        ? 'Select Date of Birth'
                        : DateFormat('MMM dd, yyyy').format(selectedDate!),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        selectedDate = date;
                      }
                    },
                    backgroundColor: AppColors.surface,
                    textColor: AppColors.textPrimary,
                    isOutlined: true,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: ['Male', 'Female', 'Other']
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      selectedGender = value;
                    },
                  ),
                ),
              ],
            ),
            const Gap(16),
            CustomTextField(
              controller: phoneController,
              label: 'Phone Number',
              hint: 'Enter phone number',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              isRequired: true,
            ),
            const Gap(16),
            CustomTextField(
              controller: emailController,
              label: 'Email',
              hint: 'Enter email address',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(16),
            CustomTextField(
              controller: addressController,
              label: 'Address',
              hint: 'Enter address',
              prefixIcon: Icons.location_on_outlined,
              maxLines: 2,
              isRequired: true,
            ),
            const Gap(16),
            CustomTextField(
              controller: medicalHistoryController,
              label: 'Medical History',
              hint: 'Enter medical history',
              prefixIcon: Icons.history,
              maxLines: 3,
            ),
            const Gap(16),
            CustomTextField(
              controller: allergiesController,
              label: 'Allergies',
              hint: 'Enter known allergies',
              prefixIcon: Icons.warning_outlined,
              maxLines: 2,
            ),
            const Gap(24),
            CustomButton(
              text: 'Add Patient',
              onPressed: () {
                if (nameController.text.isEmpty ||
                    selectedDate == null ||
                    selectedGender == null ||
                    phoneController.text.isEmpty ||
                    addressController.text.isEmpty) {
                  viewModel.setError('Please fill in all required fields');
                  return;
                }

                viewModel.createPatient(
                  name: nameController.text,
                  dateOfBirth: selectedDate!,
                  gender: selectedGender!,
                  phone: phoneController.text,
                  email: emailController.text,
                  address: addressController.text,
                  medicalHistory: medicalHistoryController.text,
                  allergies: allergiesController.text,
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
  PatientViewModel viewModelBuilder(BuildContext context) => PatientViewModel(
        context.findAncestorWidgetOfExactType<PatientRepository>()!,
        context.findAncestorWidgetOfExactType<NavigationService>()!,
        context.findAncestorWidgetOfExactType<DialogService>()!,
      );
}
