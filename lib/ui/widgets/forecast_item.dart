import 'package:flutter/material.dart';
import 'package:weather_app/helpers/helper.dart';
import 'package:weather_app/models/models.dart';

class ForecastItem extends StatelessWidget {
  final Forecast forecast;

  const ForecastItem({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Helper.toTimeFormat(forecast.jamCuaca),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 10.0),
                Text(
                  Helper.toDateFormat(forecast.jamCuaca),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '${forecast.tempC}°C',
            style:
                Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 50.0),
          ),
          const Spacer(),
          Image.asset(forecast.assetCuaca),
        ],
      ),
    );
  }
}
