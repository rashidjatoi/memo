import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/data/network_service.dart';
import 'package:notesapp/utils/utils.dart';

class AuthViewModel extends ChangeNotifier {
  // LOGIN
  bool _loginbtn = false;
  bool get isloginbtn => _loginbtn;

  // UPDATE ACCOUNT
  bool _updateAccountbtn = false;
  bool get updateAccountbtn => _updateAccountbtn;

  // FORGOT PASSWORD LOADING
  bool _forgotPasswordLoading = false;
  bool get forgotPasswordLoading => _forgotPasswordLoading;

  // SET UPDATE ACCOUNT LOADING
  void setUpdateAccountLoading(bool value) {
    _updateAccountbtn = value;
    notifyListeners();
  }

  // SET FORGOT PASSWORD LOADING
  void setForgotPasswordLoading(bool value) {
    _forgotPasswordLoading = value;
    notifyListeners();
  }

  // SET BUTTON LOGIN LOADING
  void setBtnLoginLoading(bool value) {
    _loginbtn = value;
    notifyListeners();
  }

  // FIRST NAME , LAST NAME , EMAIL , PASSWORD & CONFIRM PASSWORD CONTROLLER
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPassController;

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    confirmPassController.dispose();
    passwordController.dispose();
  }

  final NetworkService networkService = NetworkService();

  //  SIGN IN USER
  Future<void> signIn(
    String email,
    String password,
    void Function() navigateToNextScreen,
  ) async {
    try {
      setBtnLoginLoading(true);
      bool loggedIn =
          await networkService.signInWithEmailAndPassword(email, password);
      if (loggedIn) {
        setBtnLoginLoading(false);
        navigateToNextScreen();
      }
    } finally {
      setBtnLoginLoading(false);
    }
  }

  // SEND RESET LINK
  Future<void> sendResetLink(String email) async {
    try {
      setForgotPasswordLoading(true);
      await networkService.sendResetEmailToUser(email).then((value) {
        setForgotPasswordLoading(false);
      });
    } on FirebaseAuthException catch (e) {
      setForgotPasswordLoading(false);
      Utils.showToast(message: e.message.toString());
    }
  }

  // CREATE ACCOUNT FOR USER
  Future<void> createUserAccount(
    String email,
    String password,
  ) async {
    try {
      setUpdateAccountLoading(true);
      await networkService.createUserWithEmailAndPassword(email, password);
    } finally {
      setUpdateAccountLoading(false);
    }
  }

  Future<void> logoutUser(
    void Function() navigateToNextScreen,
  ) async {
    try {
      await networkService.signOut().then((value) {
        navigateToNextScreen();
        Utils.showToast(message: 'Sign out');
      });
    } on FirebaseAuthException catch (e) {
      Utils.showToast(message: e.message.toString());
    }
  }
}
