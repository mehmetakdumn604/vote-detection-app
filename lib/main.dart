import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote_detection_app/providers/tflite_controller.dart';
import 'package:vote_detection_app/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TFliteController.initModel();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TFliteController.instance)],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vote Detection App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
