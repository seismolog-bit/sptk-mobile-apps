import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/screens/news_webview.dart';
import 'package:sptk/utils/ad_helper.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/post.dart';

const int maxFailedLoadAttempts = 3;

class NewsList extends StatefulWidget {
  final List<PostModel> posts;
  final List<CategoriesModel> categories;

  const NewsList({Key? key, required this.posts, required this.categories})
      : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _inlineIndex = 3;

  late BannerAd _inlineBannerAd;

  int _interstitialLoadAttempts = 0;

  bool _isInlineBannerAdLoaded = false;

  InterstitialAd ? _interstitialAd;

  int _getListViewItemIndex(int index) {
    if(index >= _inlineIndex && _isInlineBannerAdLoaded){
      return index -1;
    }

    return index;
  }

  void _createInlineBannerAd() {
    _inlineBannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.mediumRectangle,
        request: AdRequest(),
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isInlineBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          print('Error ad Inline: ${error.message}');
          ad.dispose();
        }));

    _inlineBannerAd.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId, 
      request: AdRequest(), 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if(_interstitialLoadAttempts >= maxFailedLoadAttempts){
            _createInterstitialAd();
          }
        }
      ));
  }

  void _showInterstitialAd() {
    if(_interstitialAd != null){
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error){
          ad.dispose();
          _createInterstitialAd();
        }
      );

      _interstitialAd!.show();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _createInlineBannerAd();
    _createInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _inlineBannerAd.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: widget.posts.length,
      itemBuilder: (context, i) {
        if (_isInlineBannerAdLoaded && i == _inlineIndex) {
          return Container(
            padding: EdgeInsets.only(bottom: 10),
            width: _inlineBannerAd.size.width.toDouble(),
            height: _inlineBannerAd.size.width.toDouble(),
            child: AdWidget(
              ad: _inlineBannerAd,
            ),
          );
        } else {
          
        PostModel post = widget.posts[_getListViewItemIndex(i)];
          return GestureDetector(
            onTap: () {
              _showInterstitialAd();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewsWebView(
                        title: post.yoastHeadJson.title, url: post.link)));
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                                  children: widget.categories.map((data) {
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
        }
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
