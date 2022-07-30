import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paprika/model/movie_model/movie_model.dart';
import 'package:paprika/routes/routes.dart';
import 'package:paprika/services/grid_custome.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/movie_list/bloc/movie_list_bloc.dart';

class MoviePageParent extends StatefulWidget {
  const MoviePageParent({Key? key}) : super(key: key);

  @override
  State<MoviePageParent> createState() => _MoviePageParentState();
}

class _MoviePageParentState extends State<MoviePageParent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc()..add(FetchMovie()),
      child: MoviePage(),
    );
  }
}

class MoviePage extends StatefulWidget {
  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 245, 255),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 229, 231, 236)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  RoutesNavigation.navigateToSignUpPage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.search,
                        size: 23,
                        color: Color.fromARGB(255, 148, 148, 148),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Cari Movie",
                          style: TextStyle(
                              fontFamily: 'PoppinsMedium',
                              fontSize: 13,
                              color: Color.fromARGB(255, 148, 148, 148)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                if (state is MovieListLoading) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "Silahkan Tunggu",
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              fontSize: 13,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ));
                } else if (state is MovieListSuccess) {
                  return buildGridMovie(state.movieModel);
                  // return Container(color: Colors.green);
                } else if (state is MovieListFailed) {
                  return buildServerError();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridMovie(MovieModel? movieModel) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12),
      child: GridView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: movieModel!.results!.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
            crossAxisCount: 3,
            mainAxisSpacing: 28,
            crossAxisSpacing: 10,
            height: 265,
          ),
          itemBuilder: (context, index) {
            return buildContainerMovie(movieModel, index);
          }),
    );
  }

  Widget buildContainerMovie(MovieModel? movieModel, index) {
    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            RoutesNavigation.navigateToDetailMovie(
                context, movieModel!.results![index].id.toString());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/original/${movieModel!.results![index].posterPath}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => buildShimmerPoster(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  movieModel.results![index].originalTitle.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: const TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontSize: 12,
                      color: Color.fromARGB(255, 63, 63, 63)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[700],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        movieModel.results![index].voteAverage.toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: const TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                            fontSize: 12,
                            color: Color.fromARGB(255, 63, 63, 63)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShimmerPoster() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildServerError() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Internal Server Error",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Text(
              "Maaf terjadi kesalahan di server",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Container(
            width: 100,
            height: 170,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            width: 100,
            height: 170,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            width: 100,
            height: 170,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
