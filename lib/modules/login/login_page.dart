import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../modules/login/login_controller.dart';
import '../../shared/constants/app_constants.dart';
import '../../shared/extensions/build_context_extension.dart';
import '../../shared/theme/app_text_styles.dart';
import '../../shared/utils/app_state.dart';
import '../../shared/utils/keyboard_dismiss_on_tap.dart';
import '../../shared/widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

late LoginController _controller;
late TextEditingController _emailController;
late TextEditingController _passwordController;
late GlobalKey<FormState> _formKey;

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _controller = LoginController()..authCheck();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: _controller.isLogged,
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

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
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
                            ]),
                          ),
                          SizedBox(height: constraints.maxHeight * .02),
                          ElevatedButton(
                            onPressed:
                                state != AppState.loading ? _signIn : null,
                            child: Visibility(
                              visible: state != AppState.loading,
                              replacement: const CircularProgressIndicator(),
                              child: Text(
                                'Login',
                                style: AppTextStyles.bodyLarge(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * .05),
                          Row(
                            children: [
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Divider(
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              Text(
                                '  ou continue com  ',
                                style: AppTextStyles.bodyMedium(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Divider(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: constraints.maxHeight * .03),
                          SocialButton(
                            onTap: () => state != AppState.loading
                                ? _controller.signInWithGoogle()
                                : null,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Não tem conta?",
                style: AppTextStyles.bodySmall(
                  color: Colors.black54,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.bottom,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed('/signup'),
                      child: Text(
                        ' Cadastre-se',
                        style: AppTextStyles.bodySmall(
                          color: Theme.of(context).primaryColor,
                        ).copyWith(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      _controller.signInWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}
