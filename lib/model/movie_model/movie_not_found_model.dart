// To parse this JSON data, do
//
//     final movieNotFoundModel = movieNotFoundModelFromJson(jsonString);

import 'dart:convert';

MovieNotFoundModel movieNotFoundModelFromJson(String str) => MovieNotFoundModel.fromJson(json.decode(str));

String movieNotFoundModelToJson(MovieNotFoundModel data) => json.encode(data.toJson());

class MovieNotFoundModel {
    MovieNotFoundModel({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int? page;
    List<dynamic>? results;
    int? totalPages;
    int? totalResults;

    factory MovieNotFoundModel.fromJson(Map<String, dynamic> json) => MovieNotFoundModel(
        page: json["page"],
        results: List<dynamic>.from(json["results"].map((x) => x)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x)),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
