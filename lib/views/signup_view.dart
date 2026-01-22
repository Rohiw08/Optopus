import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 600
                ? _buildLargeScreen(size, theme)
                : _buildSmallScreen(size, theme);
          },
        ),
      ),
    );
  }

  Widget _buildLargeScreen(Size size, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            child: Lottie.asset(
              'assets/coin.json',
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(flex: 5, child: _buildMainBody(size, theme)),
      ],
    );
  }

  Widget _buildSmallScreen(Size size, ThemeData theme) {
    return Center(child: _buildMainBody(size, theme));
  }

  Widget _buildMainBody(Size size, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          if (size.width <= 600)
            Lottie.asset(
              'assets/wave.json',
              height: size.height * 0.2,
              width: size.width,
              fit: BoxFit.fill,
            ),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Sign Up', style: kLoginTitleStyle(size)),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text('Create Account', style: kLoginSubtitleStyle(size)),
          ),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextFormField(
                    controller: nameController,
                    icon: Icons.person,
                    hintText: 'Username',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 4) {
                        return 'At least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'Maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildTextFormField(
                    controller: emailController,
                    icon: Icons.email_rounded,
                    hintText: 'Gmail',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Gmail';
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'Please enter valid Gmail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  _buildTextFormField(
                    controller: passwordController,
                    icon: Icons.lock_open,
                    hintText: 'Password',
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     simpleUIController.isObscure.value
                    //         ? Icons.visibility
                    //         : Icons.visibility_off,
                    //   ),
                    //   onPressed: () {
                    //     simpleUIController.isObscureActive();
                    //   },
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 7) {
                        return 'At least enter 6 characters';
                      } else if (value.length > 13) {
                        return 'Maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                    style: kLoginTermsAndPrivacyStyle(size),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.02),
                  signUpButton(theme),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (ctx) => const LoginView()),
                      );
                      _resetForm();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                            text: " Login",
                            style: kLoginOrSignUpTextStyle(size),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    required String? Function(String?) validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      style: kTextFormFieldStyle(),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }

  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.deepPurpleAccent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
        },
        child: const Text('Sign up'),
      ),
    );
  }

  void _resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    _formKey.currentState?.reset();
  }
}
