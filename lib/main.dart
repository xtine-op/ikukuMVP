import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'routing/app_router.dart';
import 'app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: '',
    anonKey: '<YOUR_ANON_KEY>',
    // TODO: Replace with your actual anon key
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Add this line
      title: 'Flutter Demo',
      theme: appTheme,
      routerConfig: AppRouter.router,
    );
  }
}
