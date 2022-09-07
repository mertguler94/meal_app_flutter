// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;
  // final Color appBarBgColor;

  const CategoryMealsScreen(
      // this.categoryId, this.categoryTitle, this.appBarBgColor,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final appBarBgColor = routeArgs['color'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: appBarBgColor,
      ),
      body: Center(child: Text('deneme')),
    );
  }
}
