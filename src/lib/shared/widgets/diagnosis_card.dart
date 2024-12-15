import 'package:flutter/material.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/utils/date_formatter.dart';

class DiagnosisCard extends StatelessWidget {
  final String diagnosis;
  final String symptoms;
  final String treatment;
  final DateTime date;
  final VoidCallback onTap;

  const DiagnosisCard({
    Key? key,
    required this.diagnosis,
    required this.symptoms,
    required this.treatment,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormatter.formatDate(date),
                    style: TextStyles.caption.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                diagnosis,
                style: TextStyles.h3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              _buildSection('Symptoms', symptoms),
              const SizedBox(height: 8),
              _buildSection('Treatment', treatment),
            ],
          ),
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
          style: TextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyles.body2,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
