import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../core/extensions/app_dimensions.extension.dart';
import '../core/extensions/context.extensions.dart';

class AppLargeButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const AppLargeButton({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle().copyWith(
        padding: WidgetStateProperty.all(
          context.padding8,
        ),
        fixedSize: WidgetStatePropertyAll(Size(30.w, 10.h)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: context.radius8,
            side: BorderSide(
              color: context.colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          context.colorScheme.onSecondaryContainer,
        ),
        foregroundColor: WidgetStateProperty.all(
          context.colorScheme.onSecondary,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: context.textTheme.titleMedium?.copyWith(color: Colors.black, fontWeight: .w400),
      ),
    );
  }
}
