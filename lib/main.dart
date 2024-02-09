import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/firebase_options.dart';
import 'package:notesapp/view/splash_view/splash_view.dart';
import 'package:notesapp/view_model/auth_view_model.dart';
import 'package:notesapp/view_model/notes_view_model.dart';
import 'package:notesapp/view_model/password_visibility_view_model.dart';
import 'package:notesapp/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // PROVIDER
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => NotesViewModel()),
        ChangeNotifierProvider(
            create: (context) => PasswordVisibilityViewModel())
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Notes App',
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          home: const SplashView(),
        );
      },
    );
  }
}
