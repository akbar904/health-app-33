import 'package:flutter/material.dart';
import 'package:my_app/shared/styles/colors.dart';
import 'package:my_app/shared/styles/text_styles.dart';
import 'package:my_app/shared/utils/date_formatter.dart';

class PatientCard extends StatelessWidget {
  final String name;
  final String id;
  final DateTime dateOfBirth;
  final String gender;
  final VoidCallback onTap;
  final String? lastVisit;

  const PatientCard({
    Key? key,
    required this.name,
    required this.id,
    required this.dateOfBirth,
    required this.gender,
    required this.onTap,
    this.lastVisit,
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
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      name[0].toUpperCase(),
                      style: TextStyles.h3.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyles.h3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'ID: $id',
                          style: TextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _InfoItem(
                    icon: Icons.cake_outlined,
                    label: 'Age',
                    value: DateFormatter.formatAgeFromBirthDate(dateOfBirth),
                  ),
                  const SizedBox(width: 16),
                  _InfoItem(
                    icon: Icons.person_outline,
                    label: 'Gender',
                    value: gender,
                  ),
                  if (lastVisit != null) ...[
                    const SizedBox(width: 16),
                    _InfoItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Last Visit',
                      value: lastVisit!,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.caption,
                ),
                Text(
                  value,
                  style: TextStyles.body2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
