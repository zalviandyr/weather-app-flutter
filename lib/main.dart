import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/ui/screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(const Color(0xFF070928));
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegionBloc>(create: (_) => RegionBloc()),
        BlocProvider<ForecastBloc>(create: (_) => ForecastBloc()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primaryColor: const Color(0xFF070928),
          accentColor: const Color(0xFF1B86E6),
          scaffoldBackgroundColor: const Color(0xFF070928),
          brightness: Brightness.dark,
          textTheme: TextTheme(
            headline1: GoogleFonts.getFont(
              'Lato',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            headline2: GoogleFonts.getFont(
              'Lato',
              fontSize: 25,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            bodyText1: GoogleFonts.getFont(
              'Lato',
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: GoogleFonts.getFont(
              'Lato',
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
