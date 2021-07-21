import 'package:weather_app/models/models.dart';

class Forecast {
  final DateTime jamCuaca;
  final String assetCuaca;
  final String cuaca;
  final String humidity;
  final String tempC;
  final String tempF;

  Forecast({
    required this.jamCuaca,
    required this.assetCuaca,
    required this.cuaca,
    required this.humidity,
    required this.tempC,
    required this.tempF,
  });

  static List<Forecast> toList(dynamic json) {
    List<Forecast> forecasts = [];

    for (var item in json) {
      forecasts.add(
        Forecast(
            jamCuaca: DateTime.parse(item['jamCuaca']),
            assetCuaca: 'assets/icons/${item["kodeCuaca"]}.png',
            cuaca: item['cuaca'],
            humidity: item['humidity'],
            tempC: item['tempC'],
            tempF: item['tempF']),
      );
    }

    return forecasts;
  }
}

class CurrentForecast {
  final Region currentRegion;
  final Forecast forecast;
  final List<Forecast> todayForecasts;
  final List<Forecast> tomorrowForecasts;

  CurrentForecast({
    required this.currentRegion,
    required this.forecast,
    required this.todayForecasts,
    required this.tomorrowForecasts,
  });
}
