import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../shared/constants/app_constants.dart';
import '../../shared/extensions/build_context_extension.dart';
import '../../shared/theme/app_text_styles.dart';
import '../../shared/utils/app_state.dart';
import '../../shared/utils/keyboard_dismiss_on_tap.dart';
import 'signup_controller.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

late SignupController _controller;
late TextEditingController _emailController;
late TextEditingController _passwordController;
late GlobalKey<FormState> _formKey;

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    super.initState();
    _controller = SignupController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: ValueListenableBuilder(
          valueListenable: _controller.isSuccess,
          builder: (_, value, ___) {
            if (value == true) {
              Future.delayed(Duration.zero).whenComplete(
                () => Navigator.of(context).pushReplacementNamed('/home'),
              );
            }
            return LayoutBuilder(
              builder: (_, constraints) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * .05,
                ),
                child: Form(
                  key: _formKey,
                  child: ValueListenableBuilder(
                    valueListenable: _controller.state,
                    builder: (_, AppState state, __) {
                      if (state == AppState.error) {
                        context.handleError(message: _controller.failure.value);
                      }

                      return ValueListenableBuilder(
                        valueListenable: _controller.state,
                        builder: (_, AppState state, __) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cadastre-se',
                                style: AppTextStyles.heading26(
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * .03),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  label: Text(
                                    AppConstants.email,
                                    style: AppTextStyles.bodyMedium(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                    AppConstants.fieldRequired,
                                  ),
                                  Validatorless.email(
                                    AppConstants.invalidEmail,
                                  ),
                                ]),
                              ),
                              SizedBox(height: constraints.maxHeight * .02),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  label: Text(
                                    AppConstants.password,
                                    style: AppTextStyles.bodyMedium(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                    AppConstants.fieldRequired,
                                  ),
                                  Validatorless.min(
                                    6,
                                    AppConstants.minCaracters,
                                  )
                                ]),
                              ),
                              SizedBox(height: constraints.maxHeight * .05),
                              ElevatedButton(
                                onPressed:
                                    state != AppState.loading ? _signUp : null,
                                child: Visibility(
                                  visible: state != AppState.loading,
                                  replacement:
                                      const CircularProgressIndicator(),
                                  child: Text(
                                    'Continuar',
                                    style: AppTextStyles.bodyLarge(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * .05),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      _controller.signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}
