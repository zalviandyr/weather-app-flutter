import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/event_states/event_states.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/service.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastUninitialized());

  @override
  Stream<ForecastState> mapEventToState(ForecastEvent event) async* {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      if (event is ForecastSetCurrentRegion) {
        await _savePreference(preferences, event.region);

        this.add(ForecastFetchCurrent());
      }

      if (event is ForecastFetchCurrent) {
        yield ForecastLoading();

        Region currentRegion = _getPreference(preferences);
        List<Forecast> forecasts =
            await Service.fetchForecast(currentRegion.id);

        // get current forecast
        DateTime now = DateTime.now();
        List<Forecast> filterForecasts = forecasts
            .where((element) => element.jamCuaca.compareTo(now) == -1)
            .toList();
        Forecast currentForecast = filterForecasts.last;

        // get today forecast
        List<Forecast> todayForecasts = forecasts
            .where((element) => element.jamCuaca.day.compareTo(now.day) == 0)
            .toList();

        // get tomorrow forecast
        List<Forecast> tomorrowForecasts = forecasts
            .where((element) => element.jamCuaca.day.compareTo(now.day) == 1)
            .toList();

        CurrentForecast current = CurrentForecast(
          currentRegion: currentRegion,
          forecast: currentForecast,
          todayForecasts: todayForecasts,
          tomorrowForecasts: tomorrowForecasts,
        );

        yield ForecastFetchCurrentSuccess(currentForecast: current);
      }
    } catch (e) {
      print(e);
      yield ForecastError();

      // if error, fetch default region
      preferences.clear();
      this.add(ForecastFetchCurrent());
    }
  }

  _savePreference(SharedPreferences preferences, Region region) async {
    await preferences.setString('regionId', region.id);
    await preferences.setString('regionKecamatan', region.kecamatan);
    await preferences.setString('regionKota', region.kota);
    await preferences.setString('regionProvinsi', region.provinsi);
  }

  Region _getPreference(SharedPreferences preferences) {
    // Region default dki jakarta
    return Region(
      id: preferences.getString('regionId') ?? '501195',
      provinsi: preferences.getString('regionProvinsi') ?? 'DKIJakarta',
      kota: preferences.getString('regionKota') ?? 'Kota Jakarta Pusat',
      kecamatan: preferences.getString('regionKecamatan') ?? 'Jakarta Pusat',
    );
  }
}
