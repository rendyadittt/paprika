import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:paprika/model/movie_model/movie_detail_model.dart';
import 'package:paprika/repository/movie/movie_detail_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final movieDetailRepository = new MovieDetailRepository();
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) async {
      if (event is MovieDetailStartEvent) {
        emit(MovieDetailLoading());
        try {
          DetailMovieModel? detailMovieModel = await movieDetailRepository.getMovie(event.idMovie.toString());
          if (detailMovieModel!.adult != null) {
            emit(MovieDetailSuccess(detailMovieModel: detailMovieModel));
          } else {
            emit(MovieDetaiFailed());
          }
        } catch (e) {
          emit(MovieDetaiFailed());
        }
      }
    });
  }
}
