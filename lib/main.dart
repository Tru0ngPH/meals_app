import 'package:flutter/material.dart';

import './models/meal.dart';
import './dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detial_screen.dart';
import './screens/category_meal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeal;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeal.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealID) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeal.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        toggleableActiveColor: Colors.amber,
        primaryColor: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontFamily: 'RobotoCondensed',
              ),
              caption: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
          secondary: Colors.amber,
        ),
      ),
      // home: const CategoryScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routerName: (_) =>
            CategoryMealScreen(_availableMeals),
        MealDetialScreen.routeName: (_) =>
            MealDetialScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilters),
      },

      // onGenerateRoute: (settings) {
      //   if (settings.name == CategoryMealScreen.routerName) {
      //     return ...;
      //   } else if (settings.name == MealDetialScreen.routeName) {
      //     return ...;
      //   } else {
      //     return ...;
      //   }
      // },

      //Khi phat sinh lỗi thì sẽ điều hướng đến một màm hình nào đó. giống như
      // 404 eror trên web
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (_) => CategoryMealScreen(_availableMeals));
      },
    );
  }
}
