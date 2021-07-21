import 'package:equatable/equatable.dart';
import 'package:weather_app/models/models.dart';

abstract class ForecastEvent extends Equatable {
  ForecastEvent();
}

class ForecastSetCurrentRegion extends ForecastEvent {
  final Region region;

  ForecastSetCurrentRegion({required this.region});

  @override
  List<Object?> get props => [region];
}

class ForecastFetchCurrent extends ForecastEvent {
  @override
  List<Object?> get props => [];
}
