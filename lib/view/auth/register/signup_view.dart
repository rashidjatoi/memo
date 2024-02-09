import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:notesapp/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_textformfield.dart';
import '../../../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // Form Key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //AUTH VIEWMODEL
    final AuthViewModel authViewModel =
        Provider.of<AuthViewModel>(context, listen: false);

    // CONTROLLERS
    authViewModel.emailController = TextEditingController();
    authViewModel.passwordController = TextEditingController();
    authViewModel.confirmPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(
                IconlyBroken.edit,
                size: 150,
              ),

              // Sizebox
              const SizedBox(height: 30),

              // Form
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // Email
                      CustomTextFormField(
                        icon: Icons.email_outlined,
                        label: "Email",
                        hintText: "Enter your Email",
                        keyboardType: TextInputType.emailAddress,
                        textEditingController: authViewModel.emailController,
                      ),

                      const SizedBox(height: 10),

                      // Password
                      CustomTextFormField(
                        icon: Icons.lock_outline,
                        label: "Password",
                        hintText: "Enter your Password",
                        textEditingController: authViewModel.passwordController,
                      ),

                      const SizedBox(height: 10),

                      //Confirm Password

                      CustomTextFormField(
                        icon: Icons.lock_outline,
                        label: "Comfirm Password",
                        hintText: "Retype your Password",
                        textEditingController:
                            authViewModel.confirmPassController,
                      ),
                    ],
                  )),

              const SizedBox(height: 15),

              // Continue Button
              Consumer<AuthViewModel>(
                builder: (context, authViewModel, _) {
                  return CustomButton(
                      btnText: "Continue",
                      btnMargin: 0,
                      loading: authViewModel.updateAccountbtn,
                      ontap: () {
                        if (formKey.currentState!.validate()) {
                          final email =
                              authViewModel.emailController.text.trim();

                          final password =
                              authViewModel.passwordController.text.trim();
                          final confirmPassword =
                              authViewModel.confirmPassController.text.trim();

                          if (email.isEmpty ||
                              password.isEmpty ||
                              confirmPassword.isEmpty) {
                            Utils.flushBarErrorMessage(
                                'All fields are required', context);
                            return;
                          }

                          if (password != confirmPassword) {
                            Utils.flushBarErrorMessage(
                                'Passwords do not match', context);
                            return;
                          }

                          authViewModel
                              .createUserAccount(email, password)
                              .then((value) {
                            authViewModel.emailController.clear();
                            authViewModel.passwordController.clear();
                            authViewModel.confirmPassController.clear();
                          });
                        }
                      });
                },
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
