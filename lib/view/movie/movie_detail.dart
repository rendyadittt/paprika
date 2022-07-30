import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paprika/bloc/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:paprika/model/movie_model/movie_detail_model.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailPageParent extends StatefulWidget {
  String? idMovie;
  MovieDetailPageParent({@required this.idMovie});
  @override
  State<MovieDetailPageParent> createState() => _MovieDetailPageParentState();
}

class _MovieDetailPageParentState extends State<MovieDetailPageParent> {
  String? idMovie;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idMovie = widget.idMovie;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MovieDetailBloc()..add(MovieDetailStartEvent(idMovie: idMovie)),
      child: MovieDetailPage(),
    );
  }
}

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoading) {
                return buildShimmerPoster();
              } else if (state is MovieDetailSuccess) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildPoster(state.detailMovieModel),
                      buildTextTitle(state.detailMovieModel),
                      buildWidgetBackdrop(state.detailMovieModel),
                      buildTextDeskription(state.detailMovieModel),
                      buildWidgetGenre(state.detailMovieModel),
                      buildTextProductionCompany(state.detailMovieModel),
                      buildTextRelease(state.detailMovieModel),
                      buildTextSite(state.detailMovieModel),
                    ]);
              } else if (state is MovieDetaiFailed) {
                return Container(
                  color: Colors.red,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildPoster(DetailMovieModel? movieModel) {
    return Container(
      height: 600,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl:
            "https://image.tmdb.org/t/p/original/${movieModel!.posterPath}",
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
    );
  }

  Widget buildTextTitle(DetailMovieModel? movieModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movieModel!.title.toString(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: const TextStyle(
                fontFamily: 'PoppinsBold',
                fontSize: 18,
                color: Color.fromARGB(255, 63, 63, 63)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow[700],
                  size: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    movieModel.voteAverage.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: 'PoppinsBold',
                        fontSize: 15,
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

  

  Widget buildWidgetGenre(DetailMovieModel? movieModel) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8, top: 12),
              child: Text(
                "Genres",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 15,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
            Row(
              children: [
                for (var i in movieModel!.genres!)
                  Text(
                    i.name.toString() + ", ",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: const TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 12,
                        color: Color.fromARGB(255, 63, 63, 63)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextProductionCompany(DetailMovieModel? movieModel) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8, top: 12),
              child: Text(
                "Production",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 15,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
            for (var i in movieModel!.productionCompanies!)
              Text(
                i.name.toString(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 2,
                style: const TextStyle(
                    fontFamily: 'PoppinsRegular',
                    fontSize: 12,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTextRelease(DetailMovieModel? movieModel) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 23, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Release At",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 15,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
            Text(
              movieModel!.releaseDate.toString().substring(0, 10),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 3,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 12,
                  color: Color.fromARGB(255, 63, 63, 63)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextDeskription(DetailMovieModel? movieModel) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 23, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Description",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 15,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
            Text(
              movieModel!.overview.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 3,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 12,
                  color: Color.fromARGB(255, 63, 63, 63)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextSite(DetailMovieModel? movieModel) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 23, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Site",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'PoppinsBold',
                    fontSize: 15,
                    color: Color.fromARGB(255, 63, 63, 63)),
              ),
            ),
            Text(
              movieModel!.homepage.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: 3,
              style: const TextStyle(
                  fontFamily: 'PoppinsRegular',
                  fontSize: 12,
                  color: Color.fromARGB(255, 63, 63, 63)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerPoster() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
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

  Widget buildShimmerBackdrop() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWidgetBackdrop(DetailMovieModel? movieModel) {
    return movieModel!.belongsToCollection == [] || movieModel.belongsToCollection == null ? Container() : Padding(
      padding: const EdgeInsets.only(left: 18, top: 18),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 180.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/original/${movieModel.backdropPath}",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => buildShimmerBackdrop(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/original/${movieModel.belongsToCollection['poster_path']}",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => buildShimmerBackdrop(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
