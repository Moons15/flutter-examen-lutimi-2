import 'package:finalex/models/hero.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HeroHttp {
  static const String baseUrl =
      'https://superheroapi.com/api/3681284758581999/search';

  Future<List<HeroClass>> findHeroClass(String name) async {
    print(baseUrl + '/' + name);
    final response = await http.get(baseUrl + '/' + name);

    print('Busqueda - ' + response.statusCode.toString());
    print('ASDOJASOIDASDHASIUDHASIDHASUIDH');

    if (response.statusCode == 200) {
      print('1');
      var jsonDecoded = json.decode(response.body);
      print(jsonDecoded);
      if (jsonDecoded['response'] == "success") {
        print('tara bien');
        final parsed = jsonDecoded['results'];
        List<HeroClass> heroes =
            parsed.map<HeroClass>((json) => HeroClass.fromJson(json)).toList();
        return heroes;
      } else {
        // print(jsonDecoded);
        throw Exception('Error: No se cargaron los heroes');
      }
    } else {
      throw Exception('Failed to search hero');
    }
  }
}
