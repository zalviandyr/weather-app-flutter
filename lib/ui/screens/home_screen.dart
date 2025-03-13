import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/event_states/event_states.dart';
import 'package:weather_app/helpers/helper.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/ui/screens/screens.dart';
import 'package:weather_app/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ForecastBloc _forecastBloc;

  @override
  void initState() {
    _forecastBloc = BlocProvider.of<ForecastBloc>(context);

    // fetch current
    _forecastBloc.add(ForecastFetchCurrent());

    super.initState();
  }

  void _navigateToRegionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RegionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ForecastBloc, ForecastState>(
          listener: (context, state) {
            if (state is ForecastError) {
              showSnackbar(context);
            }
          },
          builder: (context, state) {
            if (state is ForecastFetchCurrentSuccess) {
              if (MediaQuery.of(context).size.width <= 720) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  children: [
                    ..._buildHeader(state.currentForecast),
                    const SizedBox(height: 5.0),
                    _buildDetailForecast(state.currentForecast),
                    const SizedBox(height: 25.0),
                    ..._buildListForecast(state.currentForecast),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            ..._buildHeader(state.currentForecast),
                            const SizedBox(height: 5.0),
                            _buildDetailForecast(state.currentForecast),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            ..._buildListForecast(state.currentForecast),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  List<Widget> _buildHeader(CurrentForecast currentForecast) {
    return [
      MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: _navigateToRegionScreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentForecast.currentRegion.kota,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(width: 10.0),
            const Icon(Icons.expand_more, size: 35.0),
          ],
        ),
      ),
      const SizedBox(height: 15.0),
      Text(
        Helper.toDateFormat(currentForecast.forecast.jamCuaca),
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 5.0),
      Text(
        currentForecast.forecast.cuaca,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 15.0),
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          Image.asset(
            currentForecast.forecast.assetCuaca,
            width: (MediaQuery.of(context).size.width <= 720)
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width * 0.25,
            fit: BoxFit.fill,
          ),
        ],
      )
    ];
  }

  Widget _buildDetailForecast(CurrentForecast currentForecast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text(
              'Temp C',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5.0),
            Text(
              '${currentForecast.forecast.tempC}°',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Temp F',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5.0),
            Text(
              '${currentForecast.forecast.tempF}°',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Humidity',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5.0),
            Text(
              '${currentForecast.forecast.humidity}%',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildListForecast(CurrentForecast currentForecast) {
    return [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Hari ini',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      const SizedBox(height: 10.0),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Forecast forecast = currentForecast.todayForecasts[index];
          return ForecastItem(forecast: forecast);
        },
        itemCount: currentForecast.todayForecasts.length,
      ),
      const SizedBox(height: 10.0),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          'Besok',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      const SizedBox(height: 10.0),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Forecast forecast = currentForecast.tomorrowForecasts[index];
          return ForecastItem(forecast: forecast);
        },
        itemCount: currentForecast.tomorrowForecasts.length,
      ),
    ];
  }
}
