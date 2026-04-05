import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:goal_decomposer/data/services/hive_services.dart';
import 'package:goal_decomposer/presentation/viewModel/goal_provider.dart';
import 'package:provider/provider.dart';
import 'core/utils/routes.dart';
import 'data/services/local_notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveServices.init();
  await LocalNotificationServices.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GoalProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goal Decomposer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        initialRoute: Routes.splash,
        onGenerateRoute: AppRouters.generateRoutes,
      ),
    );
  }
}
