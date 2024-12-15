import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/auth/auth_viewmodel.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/widgets/custom_button.dart';
import 'package:my_app/shared/widgets/custom_text_field.dart';
import 'package:gap/gap.dart';

class LoginView extends StackedView<AuthViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Gap(40),
              Icon(
                Icons.medical_services_rounded,
                size: 64,
                color: AppColors.primary,
              ),
              const Gap(24),
              Text(
                'Welcome Back',
                style: TextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              Text(
                'Log in to access your medical records',
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
                text: 'Login',
                onPressed: viewModel.login,
                isLoading: viewModel.isBusy,
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyles.body2,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      'Register',
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
