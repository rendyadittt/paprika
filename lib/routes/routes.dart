import 'package:flutter/material.dart';
import 'package:paprika/model/movie_model/movie_model.dart';
import 'package:paprika/view/movie/movie_detail.dart';
import 'package:paprika/view/movie/movie_search_page.dart';

class RoutesNavigation {
  static void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieSearchPageParent();
    }));
  }

  static void navigateToDetailMovie(BuildContext context, String? idMovie) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieDetailPageParent(idMovie: idMovie,);
    }));
  }

}