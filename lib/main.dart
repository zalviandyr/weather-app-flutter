import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/ui/screens/screens.dart';

void main() async {
  // bloc observer
  Bloc.observer = AppBlocObserver();

  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    await DesktopWindow.setMinWindowSize(Size(400, 600));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      FlutterStatusbarcolor.setStatusBarColor(const Color(0xFF070928));
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<RegionBloc>(create: (_) => RegionBloc()),
        BlocProvider<ForecastBloc>(create: (_) => ForecastBloc()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primaryColor: const Color(0xFF070928),
          scaffoldBackgroundColor: const Color(0xFF070928),
          textTheme: TextTheme(
            displayLarge: GoogleFonts.getFont(
              'Lato',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            displayMedium: GoogleFonts.getFont(
              'Lato',
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: GoogleFonts.getFont(
              'Lato',
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: GoogleFonts.getFont(
              'Lato',
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFF1B86E6),
            brightness: Brightness.dark,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
