import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/constant/cupertino.dart';
import 'package:sptk/screens/unduhan/unduhan_detail.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/unduhan.dart';
import 'package:sptk/utils/request.dart';

class UnduhanPage extends StatefulWidget {
  final List<CategoriesModel> categories;
  const UnduhanPage({Key? key, required this.categories}) : super(key: key);

  @override
  _UnduhanPageState createState() => _UnduhanPageState();
}

class _UnduhanPageState extends State<UnduhanPage> {
  List<UnduhanModel> _unduhans = [];
  List<CategoriesModel> _categories = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _categories = widget.categories;
    // fetchData().then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }

  Future<void> fetchData() async {
    try {
      var response = await Request.getGitRaw(action: 'json/downloader.json');

      List<dynamic> responseUnduhan = response;
      responseUnduhan.forEach((data) {
        _unduhans.add(UnduhanModel.fromJson(data));
      });

      setState(() {
        _unduhans = _unduhans;
      });
    } catch (e) {
      print('Fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelajahi'),
        centerTitle: true,
      ),
      body: isLoading
          ? ConstantCupertino.indicator()
          : ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12, right: 12),
                  child: GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: _categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        CategoriesModel datas = _categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UnduhanDetails(dataUnduhan: datas, categories: _categories,)));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  height: 84,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              datas.yoastHeadJson.twitterImage),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(12),
                                      ),
                                ),
                                Text(
                                  datas.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 12, color: ThemeColors.muted),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                // ListView.separated(
                //   primary: false,
                //   shrinkWrap: true,
                //   itemCount: _unduhans.length,
                //   itemBuilder: (context, i) {
                //     UnduhanModel unduhan = _unduhans[i];
                //     return Container(
                //       margin: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
                //       child: Column(
                //         children: [
                //           Container(
                //             width: double.infinity,
                //             margin: const EdgeInsets.only(left: 12, bottom: 12),
                //             alignment: Alignment.centerLeft,
                //             child: Text(unduhan.menus, style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //               fontSize: 18,
                //               color: ThemeColors.black
                //             ),),
                //           ),
                //           GridView.builder(
                //             primary: false,
                //             shrinkWrap: true,
                //             itemCount: unduhan.data.length,
                //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                //             itemBuilder: (context, index) {
                //               Datum datas = unduhan.data[index];
                //               return GestureDetector(
                //                 onTap: (){
                //                   Navigator.push(context, MaterialPageRoute(builder: (context) => UnduhanDetails(dataUnduhan: unduhan.data[index])));
                //                 },
                //                 child: Container(
                //                   margin: const EdgeInsets.all(4),
                //                   width: double.infinity,
                //                   child: Column(
                //                     children: [
                //                       Container(
                //                         height: 42,
                //                         width: 42,
                //                         margin: const EdgeInsets.only(bottom: 12),
                //                         decoration: BoxDecoration(
                //                           image: DecorationImage(image: NetworkImage(datas.icon),
                //                           fit: BoxFit.cover
                //                           ),
                //                           borderRadius: BorderRadius.circular(8)
                //                           // color: Colors.red,
                //                         ),
                //                       ),
                //                       Text(datas.title, textAlign: TextAlign.center, maxLines: 2, style: TextStyle(
                //                         fontSize: 12,
                //                         color: ThemeColors.muted
                //                       ),)
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             }
                //           )
                //         ],
                //       ),
                //     );
                //   }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                // ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
    );
  }
}
