import 'dart:convert';

import 'package:http/http.dart' as http;

class Weather{
  final String url;
  Weather(this.url);
  Future<dynamic> getJson() async{
    http.Response response =
        await http.get(Uri.parse(url));
    return response;
  }
}
Future<void> getWeather(double latitude , double longitude) async {
  Weather weather = Weather('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=d2750586c4ebe763aac192ed3c2e4578');
  var response = await weather.getJson();
  var pasingData = jsonDecode(response.body);
  print(pasingData);
}