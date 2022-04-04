import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  const CategoryMealScreen(this.availableMeals, {Key? key}) : super(key: key);
  static String routerName = '/category-meal';

  final List<Meal> availableMeals;

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  late String categoryTitle;
  late List<Meal> displayerMeal;
  var _loadingData = false;

  @override
  void initState() {
    //...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadingData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final String categoryId = routeArgs['id'] as String;
      displayerMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadingData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayerMeal.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemCount: displayerMeal.length,
          itemBuilder: (context, index) {
            return MealItem(
              id: displayerMeal[index].id,
              title: displayerMeal[index].title,
              imageUrl: displayerMeal[index].imageUrl,
              duration: displayerMeal[index].duration,
              complexity: displayerMeal[index].complexity,
              affordability: displayerMeal[index].affordability,
            );
          }),
    );
  }
}
