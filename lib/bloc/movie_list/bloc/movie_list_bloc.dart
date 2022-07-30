import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:paprika/model/movie_model/movie_model.dart';
import 'package:paprika/repository/movie/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final movieRepository = new MovieRepository();
  MovieListBloc() : super(MovieListInitial()) {
    on<MovieListEvent>((event, emit) async {
      if (event is FetchMovie) {
        emit(MovieListLoading());
        try {
          MovieModel? movieModel = await movieRepository.getMovie();
          if (movieModel!.page != null) {
            emit(MovieListSuccess(movieModel: movieModel));
          } else {
            emit(MovieListFailed());
          }
        } catch (e) {
          emit(MovieListFailed());
        }
      }
    });
  }
}


// on<PaymentBcaEvent>((event, emit) async {
//       if (event is PaymentBcaButtonPressed) {
//       emit(PaymentBcaLoading());
//       try {
//         PaymentBcaModel? paymentBcaModel = await paymentbcaRepository.payBca(
//           event.orderId,
//           event.jumlahKotor,
//           event.email,
//           event.namaDepan,
//           event.namaBelakang,
//           event.nomorPonsel,
//           event.idItem,
//           event.hargaItem,
//           event.jumlahItem,
//           event.namaItem,
//           event.uid,
//           event.idDevices,
//           event.idOutlet,
//           event.namaOutlet,
//           event.periode,
//           event.jangkaWaktu,
//         );
//         if (paymentBcaModel!.code.toString() == "201") {
//           emit(PaymentBcaSuccess(paymentBcaModel: paymentBcaModel));
//         } else {
//           emit(PaymentBcaFailed());
//           SnackbarSnackbar.snackbarAuth(
//               "Maaf terjadi kesalahan", event.context!);
//         }
//       } catch (e) {
//         emit(PaymentBcaFailed());
//         SnackbarSnackbar.snackbarAuth(
//             "Maaf terjadi kesalahan jaringan", event.context!);
//       }
//     }
//     });
//   }