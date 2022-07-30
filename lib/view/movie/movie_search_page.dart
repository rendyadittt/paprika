import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paprika/model/movie_model/movie_model.dart';
import 'package:paprika/routes/routes.dart';
import 'package:paprika/services/grid_custome.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/movie_search/bloc/movie_search_bloc.dart';

class MovieSearchPageParent extends StatefulWidget {
  const MovieSearchPageParent({Key? key}) : super(key: key);

  @override
  State<MovieSearchPageParent> createState() => _MovieSearchPageParentState();
}

class _MovieSearchPageParentState extends State<MovieSearchPageParent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieSearchBloc(),
      child: MovieSearchPage(),
    );
  }
}

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({Key? key}) : super(key: key);

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 245, 255),
      body: Column(
        children: [
          buildTextSearch(),
          Flexible(
            child: BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                if (state is MovieSearchLoading) {
                  return buildShimmerLoading();
                } else if (state is MovieSearchSuccess) {
                  return buildGridMovie(state.movieModel);
                } else if (state is MoviewSearchFailed) {
                  return buildServerError();
                } else if (state is MovieSearchNotFound) {
                  return buildNotFound();
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

  Widget buildTextSearch() {
    return Container(
      margin: EdgeInsets.only(top: 52, bottom: 12, left: 23, right: 23),
      child: TextFormField(
          textInputAction: TextInputAction.search,
          autofocus: true,
          onFieldSubmitted: (value) {
            context
                .read<MovieSearchBloc>()
                .add(MovieSearchButtonPressed(query: value.toString()));
          },
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            hintText: 'Cari Movie',
          )),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  RoutesNavigation.navigateToDetailMovie(
                      context, movieModel!.results![index].id.toString());
                },
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

  Widget buildListMovieSearch(MovieModel? movieModel) {
    return ListView.builder(
        itemCount: movieModel!.results!.length,
        itemBuilder: (context, index) {
          return buildContainerMovieSearch(movieModel, index);
        });
  }

  Widget buildContainerMovieSearch(MovieModel? movieModel, index) {
    return Container();
  }

  Widget buildNotFound() {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
             Text(
                    "Maaf movie tidak ditemukan",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style:  TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
              Text(
                    "Pastikan kamu telah mencari dengan kata kunci yang tepat",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style:  TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 12,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
          ],
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
                    style:  TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
              Text(
                    "Maaf terjadi kesalahan di server",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style:  TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 12,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 170,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
