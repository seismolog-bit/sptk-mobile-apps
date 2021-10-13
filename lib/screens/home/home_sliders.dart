import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/constant/cupertino.dart';
import 'package:sptk/screens/web_view.dart';
import 'package:sptk/utils/model/post.dart';

class HomeSliders extends StatefulWidget {
  final List<PostModel> featurePosts;
  const HomeSliders({Key? key, required this.featurePosts}) : super(key: key);

  @override
  _HomeSlidersState createState() => _HomeSlidersState();
}

class _HomeSlidersState extends State<HomeSliders> {
  final CarouselController _carouselController = CarouselController();

  int _current = 0;

  List<PostModel> _posts = [];

  @override
  void initState() {
    super.initState();
    _posts = widget.featurePosts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      height: 210,
      width: double.infinity,
      child: _posts.isEmpty
          ? ConstantCupertino.indicator()
          : Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, i, j) {
                      PostModel posts = _posts[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => WebViewScene(
                                    title: posts.yoastHeadJson.title,
                                    url: posts.link))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6, right: 6),
                          child: Stack(
                            children: [
                              CardImage(
                                  width: double.infinity,
                                  height: 200,
                                  url: posts
                                      .embedded.wpFeaturedmedia[0].sourceUrl),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 12),
                                  height: 65,
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    color: Colors.black45,
                                  ),
                                  child: Text(posts.yoastHeadJson.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: ThemeColors.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 2.0,
                        viewportFraction: .85,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _posts.asMap().entries.map((entry) {
                    return Container(
                      width: (_current == entry.key) ? 23.0 : 10.0,
                      height: 10.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 2.5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: ThemeColors.primary
                              .withOpacity(_current == entry.key ? .9 : .4)),
                    );
                  }).toList(),
                )
              ],
            ),
    );
  }
}
