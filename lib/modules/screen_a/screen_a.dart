import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen A')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.home_rounded,
                  size: 64,
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start your journey',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () => context.go('/screen-b'),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Go to Screen B'),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
