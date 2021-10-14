import 'package:flutter/material.dart';
import 'package:sptk/screens/news/news_grid.dart';
import 'package:sptk/utils/model/categories.dart';
import 'package:sptk/utils/model/unduhan.dart';

class UnduhanDetails extends StatefulWidget {
  final CategoriesModel dataUnduhan;
  final List<CategoriesModel> categories;
  const UnduhanDetails({ Key? key, required this.dataUnduhan, required this.categories }) : super(key: key);

  @override
  _UnduhanDetailsState createState() => _UnduhanDetailsState();
}

class _UnduhanDetailsState extends State<UnduhanDetails> {
  
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    fetchDataUnduhan().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchDataUnduhan() async {
    try {
      
    } catch (e) {
      print('Data Unduhan: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.dataUnduhan.name),
        centerTitle: true,
      ),
      body: NewsGrid(category: widget.dataUnduhan, categories: widget.categories,),
    );
  }
}