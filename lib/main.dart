import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/responsive_navigation.dart';
import 'services/supabase_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseService.initialize();

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GYMPLANNER',
      theme: AppTheme.darkTheme,
      home: const ResponsiveNavigation(),
    );
  }
}
