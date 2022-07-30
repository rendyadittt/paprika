part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  
  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailSuccess extends MovieDetailState {
  DetailMovieModel? detailMovieModel;
  MovieDetailSuccess({@required this.detailMovieModel});
}

class MovieDetaiFailed extends MovieDetailState {}
