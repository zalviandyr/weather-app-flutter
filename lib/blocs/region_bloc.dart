import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/event_states/event_states.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/services/service.dart';

class RegionBloc extends Bloc<RegionEvent, RegionState> {
  RegionBloc() : super(RegionUninitialized());

  @override
  Stream<RegionState> mapEventToState(RegionEvent event) async* {
    try {
      if (event is RegionFetch) {
        yield RegionLoading();

        List<Region> regions = await Service.fetchRegion();

        yield RegionFetchSuccess(regions: regions);
      }

      if (event is RegionSearch) {
        yield RegionLoading();

        String keyword = event.keyword.toLowerCase();
        List<Region> regions = await Service.fetchRegion();

        regions = regions.where((element) {
          if (element.kota.toLowerCase().contains(keyword) ||
              element.kecamatan.toLowerCase().contains(keyword) ||
              element.provinsi.toLowerCase().contains(keyword)) {
            return true;
          } else {
            return false;
          }
        }).toList();

        yield RegionFetchSuccess(regions: regions);
      }
    } catch (e) {
      print(e);

      yield RegionError();
    }
  }
}
