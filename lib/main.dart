import 'package:req_sys_finale/core/constants/color_constants.dart';
import 'package:req_sys_finale/core/routes/routes.dart';
import 'package:req_sys_finale/features/auth/handlers/auth_handler.dart';
import 'package:req_sys_finale/features/not_found/not_found_screen.dart';
import 'package:req_sys_finale/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await _setup();
  runApp(const ProviderScope(child: Alpha()));
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class Alpha extends StatelessWidget {
  const Alpha({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Pallete.primaryColor,
        dialogBackgroundColor: Colors.white,
        focusColor: Pallete.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Pallete.primaryColor,
          secondary: Pallete.accentColor,
          surface: Colors.grey[200],
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 18.0),
          displayMedium: TextStyle(fontSize: 18.0),
          displaySmall: TextStyle(fontSize: 18.0),
          headlineLarge: TextStyle(fontSize: 18.0),
          headlineMedium: TextStyle(fontSize: 18.0),
          headlineSmall: TextStyle(fontSize: 18.0),
          titleLarge: TextStyle(fontSize: 18.0),
          titleMedium: TextStyle(fontSize: 18.0),
          titleSmall: TextStyle(fontSize: 18.0),
          bodyLarge: TextStyle(fontSize: 18.0),
          bodyMedium: TextStyle(fontSize: 18.0),
          bodySmall: TextStyle(fontSize: 18.0),
          labelLarge: TextStyle(fontSize: 18.0),
          labelMedium: TextStyle(fontSize: 18.0),
          labelSmall: TextStyle(fontSize: 18.0),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // Dialog background color
          titleTextStyle: TextStyle(
              color: Pallete.primaryColor,
              fontSize: 20), // Dialog title text style
          contentTextStyle: const TextStyle(
              color: Colors.black, fontSize: 16), // Dialog content text style
        ),
      ),
      supportedLocales: const [
        Locale('en'), // English
        Locale('sh'), // Shona
        Locale('nbl') // Ndebele
      ],
      initialRoute: RoutesHelper.splashScreen,
      getPages: RoutesHelper.routes,
      unknownRoute: GetPage(name: "/", page: () => const NotFoundScreen()),
      home: const AuthHandler(),
    );
  }
}
