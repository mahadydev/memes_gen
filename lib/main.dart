import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memes_app/app/providers/meme_provider.dart';
import 'package:provider/provider.dart';

import 'app/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MemeProvider>(
            create: (context) => MemeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Memes',
        themeMode: ThemeMode.system,
        home: const SpalshScreen(),
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
      ),
    );
  }
}
