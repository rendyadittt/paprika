import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:paprika/helper/api_key.dart';
import 'package:paprika/helper/urls_helper.dart';
import 'package:paprika/model/movie_model/movie_model.dart';

class MovieSearchRepository {
  Future<MovieModel?> getMovie(String query) async {
    final params = {
      'api_key': ApiKey.apiKey.toString(),
      'query': query
    };

    final uri = Uri.https('api.themoviedb.org', '/3/search/movie', params);

    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=2cf353f4b636a1a049f4adefc54254ad&query=${query}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${ApiKey.apiKey}'
        });

    if (response.statusCode == 200) {
      print("berhasil");
      return compute(movieModelFromJson, response.body);
    } else {
      print('GAGAL');
    }
  }
}
