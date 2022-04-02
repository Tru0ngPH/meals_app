import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTitle({
    required String title,
    required IconData icon,
    required Function tabHandle,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => tabHandle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Text(
              'Cooking Up !',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildListTitle(
              title: 'Meals',
              icon: Icons.restaurant,
              tabHandle: () {
                Navigator.of(context).pushNamed('/');
              }),
          buildListTitle(
              title: 'Filters',
              icon: Icons.settings,
              tabHandle: () {
                Navigator.of(context).pushNamed(
                  FiltersScreen.routeName,
                );
              }),
        ],
      ),
    );
  }
}
