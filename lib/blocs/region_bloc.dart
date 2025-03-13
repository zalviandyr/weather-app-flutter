import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/event_states/event_states.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/service.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionUninitialized()) {
    on<RegionFetch>(_onRegionFetch);
    on<RegionSearch>(_onRegionSearch);
  }

  Future<void> _onRegionFetch(
      RegionFetch event, Emitter<RegionState> emit) async {
    try {
      emit(RegionLoading());
      final regions = await Service.fetchRegion();
      emit(RegionFetchSuccess(regions: regions));
    } catch (e, trace) {
      onError(e, trace);

      emit(RegionError());
    }
  }

  Future<void> _onRegionSearch(
      RegionSearch event, Emitter<RegionState> emit) async {
    try {
      emit(RegionLoading());

      final keyword = event.keyword.toLowerCase();
      final regions = (await Service.fetchRegion()).where((region) {
        return region.kota.toLowerCase().contains(keyword) ||
            region.kecamatan.toLowerCase().contains(keyword) ||
            region.provinsi.toLowerCase().contains(keyword);
      }).toList();

      emit(RegionFetchSuccess(regions: regions));
    } catch (e, trace) {
      onError(e, trace);

      emit(RegionError());
    }
  }
}
