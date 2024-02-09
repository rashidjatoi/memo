import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:notesapp/utils/utils.dart';
import 'package:notesapp/view_model/auth_view_model.dart';
import 'package:notesapp/view_model/password_visibility_view_model.dart';
import 'package:provider/provider.dart';

import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_textformfield.dart';
import '../../home/home_view.dart';
import '../forget_password/password_recovery.dart';
import '../register/signup_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthViewModel authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);

    authViewModel.emailController = TextEditingController();
    authViewModel.passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Memo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SIZEDBOX
            const SizedBox(height: 50),

            // LOGO MEMO
            const Icon(
              IconlyBroken.edit,
              size: 150,
            ),

            // SIZEDBOX
            const SizedBox(height: 50),

            // FORM VALIDATION
            Form(
              key: formKey,
              child: Column(
                children: [
                  // EMAIL TEXT FIELD
                  CustomTextFormField(
                    icon: IconlyLight.message,
                    label: "Email",
                    hintText: "Enter your Email",
                    textEditingController: authViewModel.emailController,
                  ),
                  const SizedBox(height: 10),

                  // PASSWORD TEXT FIELD
                  Consumer<PasswordVisibilityViewModel>(
                      builder: (context, passwordVisibility, _) {
                    return CustomTextFormField(
                      icon: IconlyLight.password,
                      hintText: "Enter your Password",
                      label: "Password",
                      obscureText: passwordVisibility.isPasswordVisible,
                      textEditingController: authViewModel.passwordController,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          passwordVisibility.togglePasswordVisibility();
                        },
                        child: Icon(
                          passwordVisibility.isPasswordVisible
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // FORGET PASSWORD
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: const Text("Forget Password"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordRecoveryView(),
                    ),
                  );
                },
              ),
            ),

            // SIZEDBOX
            const SizedBox(height: 40),

            // CONTINUE BUTTON
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, _) {
                return CustomButton(
                  btnText: "Continue",
                  loading: authViewModel.isloginbtn,
                  ontap: () {
                    if (formKey.currentState!.validate()) {
                      final email = authViewModel.emailController.text.trim();

                      final password =
                          authViewModel.passwordController.text.trim();
                      if (email.isEmpty || password.isEmpty) {
                        return Utils.flushBarErrorMessage(
                            'All fields are Required', context);
                      }
                      authViewModel.signIn(
                        authViewModel.emailController.text.toString(),
                        authViewModel.passwordController.text.toString(),
                        () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                          ).then((value) => {
                                authViewModel.emailController.clear(),
                                authViewModel.passwordController.clear()
                              });
                        },
                      );
                    }
                  },
                );
              },
            ),

            // DON'T HAVE ANY ACCOUNT
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an Account"),
                TextButton(
                  child: const Text("Sign up"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpView(),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
