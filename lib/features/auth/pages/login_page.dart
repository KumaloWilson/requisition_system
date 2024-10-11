import 'package:req_sys_finale/core/constants/local_image_constants.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/features/auth/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../animations/fade_in_slide.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/routes/routes.dart';
import '../../../custom_widgets/text_fields/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  LocalImageConstants.logo,
                  width: 200,
                  height: 200,
                ),
                Text(
                  'CENTRAL AFRICAN FORGE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Pallete.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, -5),
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const FadeInSlide(
                        duration: 1.2,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FadeInSlide(
                        duration: 1.4,
                        child: CustomTextField(
                          controller: emailController,
                          labelText: 'Email Address',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FadeInSlide(
                        duration: 1.6,
                        child: CustomTextField(
                          controller: passwordController,
                          obscureText: true,
                          labelText: 'password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      FadeInSlide(
                        duration: 1.8,
                        child: GeneralButton(
                            btnColor: Pallete.primaryColor,
                            width: screenWidth,
                            borderRadius: 10,
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onTap: () => AuthHelpers.validateAndSubmitForm(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim())),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FadeInSlide(
                        duration: 2.2,
                        child: GestureDetector(
                          onTap: () =>
                              Get.toNamed(RoutesHelper.forgotPasswordScreen),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                      text: "Forgot Password?",
                                      style: TextStyle(
                                          color: Pallete.primaryColor,
                                          fontWeight: FontWeight.w400))
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
