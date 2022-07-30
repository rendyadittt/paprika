part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
  
  @override
  List<Object> get props => [];
}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListSuccess extends MovieListState {
  MovieModel? movieModel;
  MovieListSuccess({@required this.movieModel});
}

class MovieListFailed extends MovieListState {}

