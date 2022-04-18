import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorite_screen.dart';

// class TabsScreen extends StatefulWidget {
//   const TabsScreen({Key? key}) : super(key: key);

//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }

// class _TabsScreenState extends State<TabsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Meals'),
//             bottom: const TabBar(
//               // indicator: UnderlineTabIndicator(
//               //   borderSide: BorderSide(
//               //     style: BorderStyle.solid,
//               //     color: Colors.yellow,
//               //     width: 3,
//               //   ),
//               //   insets: EdgeInsets.symmetric(
//               //     horizontal: 20,
//               //   ),
//               // ),
//               indicator: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: Colors.yellow,
//                     width: 3,
//                   ),
//                 ),
//               ),
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.category_sharp),
//                   text: 'Category',
//                 ),
//                 Tab(
//                   icon: Icon(Icons.favorite),
//                   text: 'Favorite',
//                 ),
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [
//               CategoryScreen(),
//               FavoriteScreen(),
//             ],
//           ),
//         ));
//   }
// }

class TabsScreen extends StatefulWidget {
  const TabsScreen(this.favoriteMeals, {Key? key}) : super(key: key);

  final List<Meal> favoriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;
  @override
  initState() {
    _pages = [
      {
        'page': const CategoryScreen(),
        'title': 'Category',
      },
      {
        'page': FavoriteScreen(widget.favoriteMeals),
        'title': ' Your Favorite',
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title'] as String),
        ),
        drawer: const MainDrawer(),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          //type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category_sharp),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}
