import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:paprika/repository/movie/movie_search_repository.dart';

import '../../../model/movie_model/movie_model.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final movieSearchRepository = new MovieSearchRepository();
  MovieSearchBloc() : super(MovieSearchInitial()) {
    on<MovieSearchEvent>((event, emit) async {
      if (event is MovieSearchButtonPressed) {
        emit(MovieSearchLoading());
        try {
          MovieModel? movieModel =
              await movieSearchRepository.getMovie(event.query.toString());
          if (movieModel!.page != null) {
            if (movieModel.results!.length != 0) {
              emit(MovieSearchSuccess(movieModel: movieModel));
            } else {
              emit(MovieSearchNotFound());
            }
          } else {
            emit(MoviewSearchFailed());
          }
        } catch (e) {
          emit(MoviewSearchFailed());
        }
      }
    });
  }
}
