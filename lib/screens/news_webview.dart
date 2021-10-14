import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:share/share.dart';
import 'package:sptk/constant/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final String url;
  final String title;

  const NewsWebView({ Key? key, required this.url, required this.title }) : super(key: key);

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ThemeColors.muted.withOpacity(.1)),
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Row(
            children: [IconButton(
              tooltip: 'Bagikan',
                  onPressed: () {
                    Share.share('Kunjungi ${widget.title} melalui tautan berikut: ${widget.url} with love SekolahPendidik.Com');
                    return ;
                  },
                  icon: Icon(FeatherIcons.share2, color: ThemeColors.primary)),
              IconButton(
                tooltip: 'Keluar',
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(FeatherIcons.xSquare, color: ThemeColors.danger)),
            ],
          ),
        ],
      ),
    );
  }
}