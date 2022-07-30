import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerPoster() {
  return Container(
    width: double.infinity,
    height: 170,
    child: Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      child: Text(
        'Shimmer',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
