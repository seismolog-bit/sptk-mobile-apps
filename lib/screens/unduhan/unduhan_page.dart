// ignore_for_file: avoid_print

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
    super.initState();

    _categories = widget.categories;
  }

  Future<void> fetchData() async {
    try {
      var response = await Request.getGitRaw(action: 'json/downloader.json');

      List<dynamic> responseUnduhan = response;
      for (var data in responseUnduhan) {
        _unduhans.add(UnduhanModel.fromJson(data));
      }

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
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      CategoriesModel datas = _categories[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnduhanDetails(
                                dataUnduhan: datas,
                                categories: _categories,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          width: double.infinity,
                          child: Column(
                            children: [
                              CardImage(
                                width: double.infinity,
                                height: 84,
                                url: datas.yoastHeadJson.twitterImage,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                datas.name,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ThemeColors.muted,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
    );
  }
}
