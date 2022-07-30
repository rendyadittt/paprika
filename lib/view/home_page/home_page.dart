import 'package:flutter/material.dart';
import 'package:paprika/view/movie/movie_page.dart';
import 'package:paprika/view/movie/movie_poster.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  void onItemTapped(int tappedItemIndex) {
    setState(() {
      selectedIndex = tappedItemIndex;
      _pageController!.jumpToPage(selectedIndex);
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: new BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.width / 8),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 16,
                          right: MediaQuery.of(context).size.width / 16),
                      child: Row(
                        children: [
                          Container(
                              child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 80),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      // _scaffoldKey.currentState!.openDrawer();
                                    },
                                    child: const Text(
                                          "Movies",
                                          style: TextStyle(
                                              fontFamily: 'PoppinsBold',
                                              fontSize: 23,
                                              color: Colors.white),
                                        ),)),
                          )),
                          Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 32,
                          left: 0,
                          right:0,
                          bottom: 0),
                      child: Row(
                        children: [
                          // Container(
                          //   child: Material(
                          //     color: Colors.transparent,
                          //     child: InkWell(
                          //       onTap: () {
                          //         onItemTapped(0);
                          //       },
                          //       child: Column(
                          //         children: [
                          //           Icon(
                          //             Icons.bar_chart_rounded,
                          //             color: Colors.white,
                          //             size: MediaQuery.of(context).size.width /
                          //                 16,
                          //           ),
                          //           Padding(
                          //             padding: EdgeInsets.only(
                          //                 top: MediaQuery.of(context)
                          //                         .size
                          //                         .width /
                          //                     80),
                          //             child: Text(
                          //               "Transaksi",
                          //               style: TextStyle(
                          //                   fontFamily: 'PoppinsRegular',
                          //                   fontSize: MediaQuery.of(context)
                          //                           .size
                          //                           .width /
                          //                       36,
                          //                   color: Colors.white),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Spacer(),
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              decoration: new BoxDecoration(
                                 border: Border(bottom: BorderSide(color: selectedIndex == 0 ? Colors.lightBlueAccent : Colors.transparent, width: 2)),
                                  color: selectedIndex == 0 ? Colors.white : Colors.grey),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    onItemTapped(0);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "Popular",
                                          style: TextStyle(
                                              fontFamily: 'PoppinsBold',
                                              fontSize: 13,
                                              color: selectedIndex == 0 ? Colors.lightBlueAccent : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              decoration: new BoxDecoration(
                                border: Border(bottom: BorderSide(color: selectedIndex == 1 ? Colors.lightBlueAccent : Colors.transparent, width: 2)),

                                  color: selectedIndex == 1 ? Colors.white : Colors.white),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    onItemTapped(1);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "Posters",
                                          style: TextStyle(
                                              fontFamily: 'PoppinsBold',
                                              fontSize: 13,
                                              color: selectedIndex == 1 ? Colors.lightBlueAccent : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => selectedIndex = index);
                  },
                  children: <Widget>[
                    selectedIndex == 0
                        ? MoviePageParent()
                        : selectedIndex == 1
                            ? MoviePosterPageParent()
                            : Container(),
                  ],
                )),
          ],
        ),
      );
  }
}