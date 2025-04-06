import 'package:agriplant/auth/config/routes/app_pages.dart';
import 'package:agriplant/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MainApp());
}

double maxW=0.0,maxH=0.0;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    maxW = MediaQuery.of(context).size.width;
    maxH = MediaQuery.of(context).size.height;
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        sliderTheme: SliderThemeData(
          showValueIndicator: ShowValueIndicator.always
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      // home: const OnboardingPage(),
      // home: WelcomeScreen(),
    );
  }
}


// This line store user basic data in model if cant add then it will
// trown an error to cant find collection ...etc error 
// FirebaseService.service.initAccount(auth.currentUser?.uid??"");