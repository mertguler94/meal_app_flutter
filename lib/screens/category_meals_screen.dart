import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;
  // final Color appBarBgColor;

  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen(
      // this.categoryId, this.categoryTitle, this.appBarBgColor,
      this.availableMeals,
      {Key? key})
      : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  late Color appBarBgColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    appBarBgColor = routeArgs['color'];

    displayedMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
          backgroundColor: appBarBgColor,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            Meal meal = displayedMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              complexity: meal.complexity,
              affordability: meal.affordability,
              color: appBarBgColor,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
