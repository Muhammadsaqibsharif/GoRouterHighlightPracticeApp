import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final String title;
  final IconData icon;
  final LinearGradient headerGradient;

  const GradientCard({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
    required this.headerGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(gradient: headerGradient),
            child: Row(
              children: [
                Icon(icon, color: AppColors.onPrimary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(16.0), child: child),
        ],
      ),
    );
  }
}
