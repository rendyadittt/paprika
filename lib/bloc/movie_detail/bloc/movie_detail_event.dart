part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailStartEvent extends MovieDetailEvent {
  String? idMovie;
MovieDetailStartEvent({@required this.idMovie});
}
