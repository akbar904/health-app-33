import 'package:flutter/material.dart';
import 'package:my_app/shared/styles/colors.dart';

class TextStyles {
  // Headings
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body text
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Labels and captions
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.4,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Input text
  static const TextStyle input = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // Link text
  static const TextStyle link = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.5,
  );

  // Error text
  static const TextStyle error = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    height: 1.4,
  );
}
