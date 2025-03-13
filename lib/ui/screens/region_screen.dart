import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/event_states/event_states.dart';
import 'package:weather_app/models/models.dart';
import 'package:weather_app/ui/widgets/widgets.dart';

class RegionScreen extends StatefulWidget {
  @override
  _RegionScreenState createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  late TextEditingController _textEditingController;
  late RegionBloc _regionBloc;
  late ForecastBloc _forecastBloc;

  @override
  void initState() {
    _regionBloc = BlocProvider.of<RegionBloc>(context);
    _forecastBloc = BlocProvider.of<ForecastBloc>(context);

    _textEditingController = TextEditingController();

    RegionState state = _regionBloc.state;
    if (!(state is RegionFetchSuccess)) {
      _regionBloc.add(RegionFetch());
    }

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  void _clearSearch() {
    _textEditingController.text = '';

    _regionBloc.add(RegionFetch());
    FocusScope.of(context).unfocus();
  }

  void _searchSubmit(String keyword) {
    if (keyword.isEmpty) {
      _regionBloc.add(RegionFetch());
    } else {
      _regionBloc.add(RegionSearch(keyword: keyword));
    }
  }

  void _regionSelectedAction(Region region) {
    _forecastBloc.add(ForecastSetCurrentRegion(region: region));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Wilayah',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            floating: true,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(55),
              child: Container(
                height: 50,
                margin:
                    const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cari wilayah',
                    contentPadding: const EdgeInsets.only(top: 15.0),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: _clearSearch,
                      child: Icon(Icons.close),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                  onFieldSubmitted: _searchSubmit,
                ),
              ),
            ),
          ),
          _buildListRegion(),
        ],
      ),
    );
  }

  Widget _buildListRegion() {
    return BlocBuilder<RegionBloc, RegionState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (state is RegionFetchSuccess) {
                Region region = state.regions[index];

                return RegionItem(
                  region: region,
                  onTap: _regionSelectedAction,
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            },
            childCount: state is RegionFetchSuccess
                ? state.regions.length
                : state is RegionLoading
                    ? 1
                    : 0,
          ),
        );
      },
    );
  }
}
