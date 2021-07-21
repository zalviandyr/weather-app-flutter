import 'package:equatable/equatable.dart';
import 'package:weather_app/models/models.dart';

abstract class RegionState extends Equatable {
  RegionState();
}

class RegionUninitialized extends RegionState {
  @override
  List<Object?> get props => [];
}

class RegionLoading extends RegionState {
  @override
  List<Object?> get props => [];
}

class RegionError extends RegionState {
  @override
  List<Object?> get props => [];
}

class RegionFetchSuccess extends RegionState {
  final List<Region> regions;
  RegionFetchSuccess({required this.regions});

  @override
  List<Object?> get props => [regions];
}
