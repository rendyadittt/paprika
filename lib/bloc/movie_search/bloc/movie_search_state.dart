part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
  
  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchSuccess extends MovieSearchState {
  MovieModel? movieModel;
  MovieSearchSuccess({@required this.movieModel});
}

class MovieSearchNotFound extends MovieSearchState {}

class MoviewSearchFailed extends MovieSearchState {}
