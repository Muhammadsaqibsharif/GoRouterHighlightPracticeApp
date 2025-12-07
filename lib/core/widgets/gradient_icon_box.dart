import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GradientIconBox extends StatelessWidget {
  final IconData icon;
  final double size;
  final LinearGradient? gradient;

  const GradientIconBox({
    super.key,
    required this.icon,
    this.size = 64,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: gradient ?? AppGradients.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, size: size, color: AppColors.onPrimary),
    );
  }
}
