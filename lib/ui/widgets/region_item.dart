import 'package:flutter/material.dart';
import 'package:weather_app/models/models.dart';

class RegionItem extends StatelessWidget {
  final Region region;
  final Function(Region) onTap;

  const RegionItem({required this.region, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: () => onTap(region),
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region.kota,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 7.0),
                Row(
                  children: [
                    Text(
                      'Prov. ${region.provinsi}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Spacer(),
                    Text(
                      'Kec. ${region.kecamatan}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
