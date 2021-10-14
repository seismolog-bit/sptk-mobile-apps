import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/screens/news_webview.dart';
import 'package:sptk/screens/web_view.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/post.dart';

class NewsList extends StatelessWidget {
  final List<PostModel> posts;
  final List<CategoriesModel> categories;

  const NewsList({Key? key, required this.posts, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, i) {
        PostModel post = posts[i];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NewsWebView(
                        title: post.yoastHeadJson.title,
                        url:post.link))),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                CardImage(
                    width: size.width * .35,
                    height: 95,
                    url: post.embedded.wpFeaturedmedia[0].sourceUrl),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: post.categories.map((e) {
                          return Row(
                            children: [
                              Wrap(
                                children: categories.map((data) {
                                  if (e == data.id) {
                                    return Text(
                                      data.name.toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                        color: ThemeColors.primary,
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                }).toList(),
                              ),
                              const SizedBox(width: 4),
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        post.yoastHeadJson.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            FeatherIcons.calendar,
                            size: 10,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('EEE, dd MMM yyy ')
                                .add_Hm()
                                .format(post.date),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: ThemeColors.muted),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
