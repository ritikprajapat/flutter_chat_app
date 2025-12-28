import 'app.dart';

export 'package:flutter/material.dart';
export 'package:provider/provider.dart';
export 'package:flutter/services.dart';

export '../../main.dart';
export '../app/app.dart';
export '../core/core.dart';
export '../data/data.dart';
export '../modules/modules.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppChangeNotifierProvider.providers,
      child: MaterialApp(
        scaffoldMessengerKey: SnackBarHelper.scaffoldMessengerKey,
        title: 'Chat App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6366F1), brightness: Brightness.dark),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
