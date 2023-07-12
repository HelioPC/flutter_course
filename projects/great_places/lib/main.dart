import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:great_places/pages/place_form_page.dart';
import 'package:great_places/pages/places_list_page.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GreatPlaces()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.indigo,
          brightness: Brightness.dark,
        ),
        routes: {
          AppRoutes.HOME: (context) => const PlacesListPage(),
          AppRoutes.FORMROUTE: (context) => const PlaceFormPage(),
        },
      ),
    );
  }
}
