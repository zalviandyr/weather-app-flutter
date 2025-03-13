import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/event_states/event_states.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/service.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc() : super(ForecastUninitialized()) {
    on<ForecastSetCurrentRegion>(_onSetCurrentRegion);
    on<ForecastFetchCurrent>(_onFetchCurrentForecast);
  }

  Future<void> _onSetCurrentRegion(
      ForecastSetCurrentRegion event, Emitter<ForecastState> emit) async {
    final preferences = await SharedPreferences.getInstance();

    await _savePreference(preferences, event.region);
    add(ForecastFetchCurrent());
  }

  Future<void> _onFetchCurrentForecast(
      ForecastFetchCurrent event, Emitter<ForecastState> emit) async {
    final preferences = await SharedPreferences.getInstance();
    try {
      emit(ForecastLoading());

      final currentRegion = _getPreference(preferences);
      final forecasts = await Service.fetchForecast(currentRegion.id);

      // Mendapatkan ramalan cuaca saat ini
      final now = DateTime.now();
      final filterForecasts =
          forecasts.where((f) => f.jamCuaca.isBefore(now)).toList();
      final currentForecast =
          filterForecasts.isNotEmpty ? filterForecasts.last : null;

      // Pisahkan forecast berdasarkan hari
      final todayForecasts =
          forecasts.where((f) => f.jamCuaca.day == now.day).toList();
      final tomorrowForecasts =
          forecasts.where((f) => f.jamCuaca.day == now.day + 1).toList();

      final current = CurrentForecast(
        currentRegion: currentRegion,
        forecast: currentForecast!,
        todayForecasts: todayForecasts,
        tomorrowForecasts: tomorrowForecasts,
      );

      emit(ForecastFetchCurrentSuccess(currentForecast: current));
    } catch (e, trace) {
      onError(e, trace);

      emit(ForecastError());

      // Jika terjadi error, reset preferensi dan coba fetch ulang
      await preferences.clear();
      add(ForecastFetchCurrent());
    }
  }

  Future<void> _savePreference(
      SharedPreferences preferences, Region region) async {
    await preferences.setString('regionId', region.id);
    await preferences.setString('regionKecamatan', region.kecamatan);
    await preferences.setString('regionKota', region.kota);
    await preferences.setString('regionProvinsi', region.provinsi);
  }

  Region _getPreference(SharedPreferences preferences) {
    return Region(
      id: preferences.getString('regionId') ?? '501195',
      provinsi: preferences.getString('regionProvinsi') ?? 'DKI Jakarta',
      kota: preferences.getString('regionKota') ?? 'Kota Jakarta Pusat',
      kecamatan: preferences.getString('regionKecamatan') ?? 'Jakarta Pusat',
    );
  }
}
