// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../dummy_data.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;
  // final Color appBarBgColor;

  static const routeName = '/category-meals';

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

    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
          backgroundColor: appBarBgColor,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            Meal meal = categoryMeals[index];
            return MealItem(
                id: meal.id,
                title: meal.title,
                imageUrl: meal.imageUrl,
                duration: meal.duration,
                complexity: meal.complexity,
                affordability: meal.affordability);
          },
          itemCount: categoryMeals.length,
        ));
  }
}
