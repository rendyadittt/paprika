import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:paprika/helper/api_key.dart';
import 'package:paprika/helper/urls_helper.dart';
import 'package:paprika/model/movie_model/movie_model.dart';

class MovieRepository {
  Future<MovieModel?> getMovie() async {
    final params = {
      'api_key': ApiKey.apiKey.toString(),
    };

    final uri = Uri.https('api.themoviedb.org', '/3/movie/popular', params);

    final response = await http.get(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'bearer ${ApiKey.apiKey}'
        });

    if (response.statusCode == 200) {
      return compute(movieModelFromJson, response.body);
    } else {
      print('GAGAL');
    }
  }
}
