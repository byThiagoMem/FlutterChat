import 'package:flutter/material.dart';

import '../../shared/widgets/custom_diolog.dart';

extension BuildContextExtension on BuildContext {
  void handleSuccess({
    String title = 'Sucesso',
    required String message,
    bool? barrierDismissible,
    String actionLabel = 'Continuar',
    VoidCallback? onAction,
    String optionLabel = 'Voltar',
    VoidCallback? onOption,
  }) {
    CustomDiolog.show(
      context: this,
      type: DialogType.success,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      actionLabel: actionLabel,
      onAction: onAction,
      optionLabel: optionLabel,
      onOption: onOption,
    );
  }

  void handleError({
    String title = 'Oops',
    required String message,
    bool? barrierDismissible,
    String actionLabel = 'Continuar',
    VoidCallback? onAction,
    String optionLabel = 'Voltar',
    VoidCallback? onOption,
  }) {
    CustomDiolog.show(
      context: this,
      type: DialogType.error,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      actionLabel: actionLabel,
      onAction: onAction,
      optionLabel: optionLabel,
      onOption: onOption,
    );
  }
}
