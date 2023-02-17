import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

enum DialogType { success, error }

class CustomDiolog {
  static Future<void> show({
    required BuildContext context,
    required DialogType type,
    required String title,
    required String message,
    String actionLabel = 'Continuar',
    VoidCallback? onAction,
    String optionLabel = 'Voltar',
    VoidCallback? onOption,
    bool? barrierDismissible,
  }) async {
    var icon = type == DialogType.success ? Icons.check : Icons.close;

    var color =
        type == DialogType.success ? Colors.green[400] : Colors.red[400];

    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (_) => LayoutBuilder(
        builder: (_, constraints) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            insetPadding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * .15,
            ),
            child: Container(
              width: constraints.maxWidth,
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: color!.withOpacity(.3),
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => onAction ?? Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        constraints.maxWidth * .5,
                        double.minPositive,
                      ),
                      primary: color,
                    ),
                    child: Text(
                      actionLabel,
                      style: AppTextStyles.bodyMedium(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: onOption != null,
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Text(
                            optionLabel,
                            style: AppTextStyles.bodyMedium(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
