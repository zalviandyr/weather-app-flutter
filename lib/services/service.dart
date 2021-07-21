import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/models.dart';

class Service {
  static final String _baseurl = 'https://ibnux.github.io/BMKG-importer/cuaca';

  static Future<List<Region>> fetchRegion() async {
    Uri url = Uri.parse(_baseurl + '/wilayah.json');
    var response = await http.get(url);

    dynamic json = jsonDecode(response.body);
    return Region.toList(json);
  }

  static Future<List<Forecast>> fetchForecast(String regionId) async {
    Uri url = Uri.parse(_baseurl + '/' + regionId + '.json');
    var response = await http.get(url);

    dynamic json = jsonDecode(response.body);
    return Forecast.toList(json);
  }
}
