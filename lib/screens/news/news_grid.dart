import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/constant/cupertino.dart';
import 'package:sptk/screens/news/news_list.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/post.dart';
import 'package:sptk/utils/request.dart';

class NewsGrid extends StatefulWidget {
  final CategoriesModel category;
  final List<CategoriesModel> categories;
  const NewsGrid({Key? key, required this.category, required this.categories}) : super(key: key);

  @override
  _NewsGridState createState() => _NewsGridState();
}

class _NewsGridState extends State<NewsGrid> {
  bool isLoading = false;
  bool isEnd = false;
  bool isFirst = true;
  int page = 1;

  List<PostModel> _posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((_) {
      isFirst = false;
    });
  }

  Future<void> fetchData() async {
    try {
      var responsePost = await Request.get(
          action: 'posts?categories=${widget.category.id}&page=$page&_embed');

      List<dynamic> resPosts = responsePost;
      resPosts.forEach((data) {
        _posts.add(PostModel.fromJson(data));
      });

      setState(() {
        _posts = _posts;
      });
    } catch (e) {
      print('Fetch news grid: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isFirst
        ? ConstantCupertino.indicator()
        : ListView(
            children: [
              // GridView.builder(
              //   padding: const EdgeInsets.only(left: 10, right: 10),
              //   primary: false,
              //   shrinkWrap: true,
              //   itemCount: _posts.length,
              //   itemBuilder: (context, i) {
              //     PostModel post = _posts[i];
              //     return Container(
              //       margin: const EdgeInsets.all(6),
              //       child: Column(
              //         children: [
              //           CardImage(
              //               width: double.infinity,
              //               height: 105,
              //               url: post.embedded.wpFeaturedmedia[0].sourceUrl),
              //           const SizedBox(height: 6),
              //           Text(
              //             post.yoastHeadJson.title,
              //             maxLines: 2,
              //             overflow: TextOverflow.ellipsis,
              //             style: const TextStyle(
              //                 fontWeight: FontWeight.w500, fontSize: 14),
              //           ),
              //           const SizedBox(height: 4),
              //           Row(
              //             children: [
              //               Icon(
              //                 FeatherIcons.calendar,
              //                 size: 12,
              //                 color: ThemeColors.primary,
              //               ),
              //               const SizedBox(
              //                 width: 6,
              //               ),
              //               Expanded(
              //                 child: Text(
              //                   DateFormat('EEE, dd MMM yyyy')
              //                       .format(DateTime.now())
              //                       .toString(),
              //                   style: TextStyle(
              //                       color: ThemeColors.primary,
              //                       fontSize: 10,
              //                       fontWeight: FontWeight.w400),
              //                 ),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //     );
              //   },
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2),
              // ),
              NewsList(posts: _posts, categories: widget.categories,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: isLoading ? ConstantCupertino.indicator() : TextButton(
                    onPressed: () {
                      if (!isEnd) {
                        setState(() {
                          isLoading = true;
                          page = page + 1;
                        });

                        print(page);

                        fetchData().then((value) {
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
              )
            ],
          );
  }
}
