import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/screens/news_webview.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Apps'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(FeatherIcons.info, color: ThemeColors.primary,),
            title: const Text('Tentang aplikasi'),
            subtitle: const Text('V. 1.0.0', style: TextStyle(
              fontSize: 11
            ),),
            // trailing: Icon(FeatherIcons.chevronRight, color: ThemeColors.muted.withOpacity(.5),),
          ),
          ListTile(
            leading: Icon(FeatherIcons.key, color: ThemeColors.primary,),
            title: const Text('Privacy policy'),
            // subtitle: const Text('V. 1.0.0', style: TextStyle(
            //   fontSize: 11
            // ),),
            trailing: Icon(FeatherIcons.chevronRight, color: ThemeColors.muted.withOpacity(.5),),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NewsWebView(
                        title: 'Privacy policy',
                        url:'https://www.sekolahpendidik.com/privacy-policy/'))),
          ),
          ListTile(
            leading: Icon(FeatherIcons.shield, color: ThemeColors.primary,),
            title: const Text('Disclaimer'),
            // subtitle: const Text('V. 1.0.0', style: TextStyle(
            //   fontSize: 11
            // ),),
            trailing: Icon(FeatherIcons.chevronRight, color: ThemeColors.muted.withOpacity(.5),),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NewsWebView(
                        title: 'Disclaimer',
                        url:'https://www.sekolahpendidik.com/disclaimer/'))),
          ),
          ListTile(
            leading: Icon(FeatherIcons.alertTriangle, color: ThemeColors.primary,),
            title: const Text('Term and conditions'),
            // subtitle: const Text('V. 1.0.0', style: TextStyle(
            //   fontSize: 11
            // ),),
            trailing: Icon(FeatherIcons.chevronRight, color: ThemeColors.muted.withOpacity(.5),),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NewsWebView(
                        title: 'Term and conditions',
                        url:'https://www.sekolahpendidik.com/terms-and-conditions/'))),
          ),
          ListTile(
            leading: Icon(FeatherIcons.mail, color: ThemeColors.primary,),
            title: const Text('Contact'),
            // subtitle: const Text('V. 1.0.0', style: TextStyle(
            //   fontSize: 11
            // ),),
            trailing: Icon(FeatherIcons.chevronRight, color: ThemeColors.muted.withOpacity(.5),),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const NewsWebView(
                        title: 'Contant',
                        url:'https://www.sekolahpendidik.com/contact/'))),
          ),
        ],
      ),
    );
  }
}
