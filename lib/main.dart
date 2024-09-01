
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_now/screens/launch_screen/launch_screen.dart';
import 'package:shop_now/utils/configuration/firebase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await FirebaseConfig().init();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
      home: Splash()
    );
  }
}


