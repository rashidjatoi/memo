import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:notesapp/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../resources/components/custom_button.dart';
import '../../../resources/components/custom_textformfield.dart';

class PasswordRecoveryView extends StatefulWidget {
  const PasswordRecoveryView({super.key});

  @override
  State<PasswordRecoveryView> createState() => _PasswordRecoveryViewState();
}

class _PasswordRecoveryViewState extends State<PasswordRecoveryView> {
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("Forget Password"),
        elevation: 0.8,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),

              // LOGO ICON
              const Icon(
                IconlyLight.send,
                size: 150,
              ),

              // SIZEDBOX
              const SizedBox(height: 10),

              // TEXT
              const Text(
                'Please provide the email address that you used when you signed up for your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              // SIZEDBOX
              const SizedBox(height: 40),

              // EMAIL FORM
              Form(
                key: formKey,
                child: CustomTextFormField(
                  hintText: 'Email',
                  label: 'Email',
                  icon: Icons.email_outlined,
                  textEditingController: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                ),
              ),

              // SIZEDBOX
              const SizedBox(height: 20),

              // SEND BUTTON
              Consumer<AuthViewModel>(
                builder: (context, value, child) {
                  return CustomButton(
                    btnMargin: 0,
                    btnText: "Send",
                    loading: value.forgotPasswordLoading,
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        await value.sendResetLink(
                          emailController.text.toString(),
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
