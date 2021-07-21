import 'package:equatable/equatable.dart';
import 'package:weather_app/models/models.dart';

abstract class ForecastState extends Equatable {
  ForecastState();
}

class ForecastUninitialized extends ForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastLoading extends ForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastError extends ForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastFetchCurrentSuccess extends ForecastState {
  final CurrentForecast currentForecast;

  ForecastFetchCurrentSuccess({required this.currentForecast});

  @override
  List<Object?> get props => [currentForecast];
}
