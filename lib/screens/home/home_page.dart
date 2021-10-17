// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/constant/cupertino.dart';
import 'package:sptk/screens/home/home_sliders.dart';
import 'package:sptk/screens/news/news_list.dart';
import 'package:sptk/screens/news_webview.dart';
import 'package:sptk/screens/notification/notification_screen.dart';
import 'package:sptk/screens/web_view.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/post.dart';
import 'package:sptk/utils/request.dart';

class HomePage extends StatefulWidget {
  final List<PostModel> posts;
  final List<PostModel> featurePosts;
  final List<CategoriesModel> categories;
  const HomePage({Key? key, required this.posts, required this.featurePosts, required this.categories}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  bool isEnd = false;
  bool isLoading = false, firstLoading = false;

  List<PostModel> _posts = [];
  List<CategoriesModel> _categories = [];

  String timeNow = '';

  @override
  void initState() {
    super.initState();

    changeTime();

    _posts = widget.posts;
    _categories = widget.categories;

    // categoryFetch().then((_) => postFetch().then((_) {
    //       setState(() {
    //         firstLoading = false;
    //       });
    //     }));
  }

  void changeTime() {
    var hour = DateTime.now().hour;
    setState(() {
      if (hour < 10) {
        timeNow = 'selamat pagi';
      } else if (hour < 14) {
        timeNow = 'selamat siang';
      } else if (hour < 18) {
        timeNow = 'selamat sore';
      } else {
        timeNow = 'selamat malam';
      }
    });
  }

  Future<void> categoryFetch() async {
    try {
      var responseCategories =
          await Request.get(action: 'categories?per_page=100');

      List<dynamic> resCategories = responseCategories;

      for (var data in resCategories) {
        _categories.add(CategoriesModel.fromJson(data));
      }

      setState(() {
        _categories = _categories;
      });
    } catch (e) {
      Toast.show('Tidak ada berita');
      print('Categories: $e');
    }
  }

  Future<void> postFetch() async {
    try {
      var responsePost =
          await Request.get(action: 'posts?page=$page&_embed');
      List<dynamic> resPosts = responsePost;
      for (var data in resPosts) {
        _posts.add(PostModel.fromJson(data));
      }

      setState(() {
        _posts = _posts;
      });
    } catch (e) {
      Toast.show('Tidak ada berita');
      setState(() {
        isEnd = true;
      });
      print('Post Page: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, $timeNow!'),
            Text(
              DateFormat('EEE, dd MMMM yyyy').format(DateTime.now()).toString(),
              style: TextStyle(
                  color: ThemeColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen())), icon: const Icon(Icons.notifications_none))
        ],
      ),
      body: firstLoading
          ? ConstantCupertino.indicator()
          : ListView(
              children: [
                HomeSliders(featurePosts: widget.featurePosts,),
                Constant.title('Menu'),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const NewsWebView(
                                        title: 'Simpatika login admin Madrasah',
                                        url:
                                            'https://paspor.siap-online.com/cas/login',
                                      ))),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            // height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: ThemeColors.primary.withOpacity(.5)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 45,
                                  height: 50,
                                  child: Icon(
                                    FeatherIcons.server,
                                    color: ThemeColors.primary,
                                    size: 28,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Admin',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Login sebagai Admin',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors.muted,
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const NewsWebView(
                                        title: 'Simpatika login PTK',
                                        url:
                                            'https://paspor.siap-online.com/cas/login?&service=https://padamu.siap.web.id/login',
                                      ))),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            // height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: ThemeColors.warning.withOpacity(.5)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 45,
                                  height: 50,
                                  child: Icon(
                                    FeatherIcons.monitor,
                                    color: ThemeColors.warning,
                                    size: 28,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'PTK',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Login sebagai PTK',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: ThemeColors.muted,
                                              fontSize: 13)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Constant.title('Postingan Terbaru'),
                NewsList(posts: _posts, categories: _categories),
                isLoading
                    ? SizedBox(height: 52, child: ConstantCupertino.indicator())
                    : isEnd
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Text(
                              'Tidak ada berita terdahulu',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: ThemeColors.primary,
                                // fontSize: 12
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: TextButton(
                                onPressed: () {
                                  if (!isEnd) {
                                    setState(() {
                                      isLoading = true;
                                      page = page + 1;
                                    });

                                    print(page);

                                    postFetch().then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  }
                                },
                                child: Text(
                                  'Lebih banyak',
                                  style: TextStyle(color: ThemeColors.primary),
                                )),
                          ),
                          const SizedBox(height: 60,)
              ],
            ),
    );
  }
}
