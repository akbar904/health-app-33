import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/auth/auth_viewmodel.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/widgets/custom_button.dart';
import 'package:my_app/shared/widgets/custom_text_field.dart';
import 'package:gap/gap.dart';

class RegisterView extends StackedView<AuthViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(24),
              Text(
                'Create Account',
                style: TextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              Text(
                'Sign up to start managing patient records',
                style: TextStyles.body2,
                textAlign: TextAlign.center,
              ),
              const Gap(40),
              if (viewModel.modelError != null) ...[
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
                const Gap(24),
              ],
              CustomTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                onChanged: viewModel.setName,
                prefixIcon: Icons.person_outline,
                textInputAction: TextInputAction.next,
              ),
              const Gap(16),
              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                onChanged: viewModel.setEmail,
                prefixIcon: Icons.email_outlined,
                textInputAction: TextInputAction.next,
              ),
              const Gap(16),
              CustomTextField(
                label: 'Password',
                hint: 'Enter your password',
                obscureText: true,
                onChanged: viewModel.setPassword,
                prefixIcon: Icons.lock_outline,
                textInputAction: TextInputAction.done,
              ),
              const Gap(24),
              CustomButton(
                text: 'Register',
                onPressed: viewModel.register,
                isLoading: viewModel.isBusy,
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyles.body2,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Login',
                      style: TextStyles.link,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(BuildContext context) => AuthViewModel(
        context.findAncestorWidgetOfExactType<AuthRepository>()!,
        context.findAncestorWidgetOfExactType<NavigationService>()!,
        context.findAncestorWidgetOfExactType<DialogService>()!,
      );
}
