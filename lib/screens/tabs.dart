import 'package:flutter/material.dart';
import 'package:sptk/constant/constant.dart';
import 'package:sptk/constant/cupertino.dart';
import 'package:sptk/screens/home/home_page.dart';
import 'package:sptk/screens/navbar/custom_button_navbar.dart';
import 'package:sptk/screens/unduhan/unduhan_page.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/post.dart';
import 'package:sptk/utils/request.dart';

class TabsScreen extends StatefulWidget {
  final int initialPage;
  const TabsScreen({Key? key, this.initialPage = 1}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedPage = 1;

  PageController pageController = PageController(initialPage: 1);

  bool isLoading = true;
  List<PostModel> _posts = [];
  List<PostModel> _featurePosts = [];
  List<CategoriesModel> _categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedPage = widget.initialPage;
    pageController = PageController(initialPage: widget.initialPage);

    fetchCategories();
    fetchFeature();
    fetchPosts().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchFeature() async {
    try {
      var responsePost =
          await Request.get(action: 'posts?categories=193&per_page=5&_embed');

      List<dynamic> resPosts = responsePost;
      resPosts.forEach((data) {
        _featurePosts.add(PostModel.fromJson(data));
      });

      setState(() {
        _featurePosts = _featurePosts;
      });
    } catch (e) {
      print('Fetch feature: $e');
    }
  }

  Future<void> fetchPosts() async {
    try {
      var responsePost =
          await Request.get(action: 'posts?categories=1&page=1&_embed');

      List<dynamic> resPosts = responsePost;
      resPosts.forEach((data) {
        _posts.add(PostModel.fromJson(data));
      });

      setState(() {
        _posts = _posts;
      });
    } catch (e) {
      print('Fetch post: $e');
    }
  }

  Future<void> fetchCategories() async {
    try {
      var responseCategories =
          await Request.get(action: 'categories?per_page=100');

      List<dynamic> resCategories = responseCategories;

      resCategories.forEach((data) {
        _categories.add(CategoriesModel.fromJson(data));
      });

      setState(() {
        _categories = _categories;
      });
    } catch (e) {
      print('Fetch categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? ConstantCupertino.indicator()
          : Stack(
              children: [
                Container(
                  color: ThemeColors.white,
                ),
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedPage = index;
                    });
                  },
                  children: [
                    const Center(child: Text('Info')),
                    Center(
                      child: HomePage(
                        posts: _posts,
                        featurePosts: _featurePosts,
                        categories: _categories,
                      ),
                    ),
                    const Center(
                      child: UnduhanPage(),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavBar(
                    selectedIndex: selectedPage,
                    onTap: (index) {
                      setState(() {
                        selectedPage = index;
                      });
                      pageController.jumpToPage(selectedPage);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
