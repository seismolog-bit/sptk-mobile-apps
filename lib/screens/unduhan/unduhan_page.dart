import 'package:flutter/material.dart';

class UnduhanPage extends StatefulWidget {
  const UnduhanPage({ Key? key }) : super(key: key);

  @override
  _UnduhanPageState createState() => _UnduhanPageState();
}

class _UnduhanPageState extends State<UnduhanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unduhan'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Unduhan'),
      ),
    );
  }
}