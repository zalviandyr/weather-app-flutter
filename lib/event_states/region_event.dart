import 'package:equatable/equatable.dart';

abstract class RegionEvent extends Equatable {
  RegionEvent();
}

class RegionFetch extends RegionEvent {
  @override
  List<Object?> get props => [];
}

class RegionSearch extends RegionEvent {
  final String keyword;

  RegionSearch({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}
