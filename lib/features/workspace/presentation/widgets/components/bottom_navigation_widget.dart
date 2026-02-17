import 'package:flutter/material.dart';
import 'package:optopus/core/widgets/custom_outlined_widget.dart';

class BottomNavigationWidget extends StatelessWidget {
  final String cancelText;
  final String proceedText;
  final VoidCallback onCancel;
  final VoidCallback onProceed;
  final bool isProceedLoading;
  final bool isCancelLoading;
  const BottomNavigationWidget({
    super.key,
    required this.cancelText,
    required this.proceedText,
    required this.onCancel,
    required this.onProceed,
    this.isProceedLoading = false,
    this.isCancelLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomOutlinedButton(
            width: 80,
            height: 30,
            text: cancelText,
            alignment: Alignment.center,
            onPressed: onCancel,
            isLoading: isCancelLoading,
            backgroundColor: theme.colorScheme.surfaceBright,
            hoverBackgroundColor: theme.colorScheme.surfaceBright.withValues(
              alpha: 0.5,
            ),
            borderColor: Colors.transparent,
            hoverBorderColor: Colors.transparent,
          ),
          const SizedBox(width: 10),
          CustomOutlinedButton(
            width: 80,
            height: 30,
            text: proceedText,
            alignment: Alignment.center,
            onPressed: onProceed,
            textColor: theme.colorScheme.onPrimary,
            backgroundColor: theme.colorScheme.primary,
            isLoading: isProceedLoading,
            hoverBackgroundColor: theme.colorScheme.primary.withValues(
              alpha: 0.5,
            ),
            borderColor: Colors.transparent,
            hoverBorderColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
