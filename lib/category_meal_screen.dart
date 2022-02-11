import 'package:flutter/material.dart';

class CategoryMealScreen extends StatelessWidget {
  const CategoryMealScreen({Key? key}) : super(key: key);
  static String routerName = '/category-meal';

  // const CategoryMealScreen({
  //   Key? key,
  //   required this.id,
  //   required this.title,
  // }) : super(key: key);

  // final String id;
  // final String title;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String title = routeArgs['title'] as String;
    final String id = routeArgs['id'] as String;
    ;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
