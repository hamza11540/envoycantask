import 'package:flutter/material.dart';
import 'package:movieapp/application/main_config/main_config.dart' as config;
import 'package:movieapp/presentation/utilis/scroll_behavior.dart';
import  'package:movieapp/mixin/base_mixin.dart';
import 'package:movieapp/ui/view_model/view_model.dart';
import 'package:provider/provider.dart';
import 'application/core/routes/route_generator.dart';
import 'application/core/routes/route_path.dart';

Future<void> main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await config.initMainServiceLocator();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with BaseMixin {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Figtree'),
        debugShowCheckedModeBanner: false,

        builder: (context, child) => ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: child!,
        ),
        initialRoute: RoutePath.initialRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: routeNavigator.key(),
      ),
    );
  }
}


