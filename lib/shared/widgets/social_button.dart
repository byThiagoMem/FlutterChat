import 'package:flutter/material.dart';

import '../../shared/theme/app_text_styles.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.grey,
          )
        ],
        color: Theme.of(context).primaryColor.withOpacity(.6),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3.0,
                  horizontal: 5.0,
                ),
                child: Image.asset(
                  'assets/icons/google_logo.png',
                  height: 40,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Entrar com Google',
              style: AppTextStyles.bodyLarge(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
