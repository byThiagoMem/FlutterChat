import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../modules/chat/chat_page.dart';
import '../../modules/home/home_page.dart';
import '../../modules/login/login_page.dart';
import '../../modules/signup/signup_page.dart';
import '../../shared/theme/app_text_styles.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xFF4c32a8),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF4c32a8).withOpacity(.5),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.sourceSansPro(color: Colors.white),
          fillColor: Colors.white10,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.maxFinite, 45),
            primary: const Color(0xFF4c32a8),
            onSurface: const Color(0xFF4c32a8),
            textStyle: AppTextStyles.bodyLarge(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFF4c32a8),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF4c32a8),
        ),
      ),
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
        '/home': (_) => const HomePage(),
        '/chat': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return ChatPage(id: args['id']);
        },
      },
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const LoginPage(),
    );
  }
}
