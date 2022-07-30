import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MoviePosterPageParent extends StatefulWidget {
  const MoviePosterPageParent({Key? key}) : super(key: key);

  @override
  State<MoviePosterPageParent> createState() => _MoviePosterPageParentState();
}

class _MoviePosterPageParentState extends State<MoviePosterPageParent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
    );
  }
}