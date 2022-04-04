import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class MealDetialScreen extends StatelessWidget {
  const MealDetialScreen(this.toggleFavorite, this.isFavorite, {Key? key})
      : super(key: key);

  final Function toggleFavorite;
  final Function isFavorite;

  static String routeName = '/meal-detial-screen';

  Widget _buildContainer(Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: child,
    );
  }

  Widget _buildSelectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Colors.black, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)!.settings.arguments as String;
    final Meal selectMeal = dummyMeal.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSelectionTitle(context, 'Ingredients'),
            _buildContainer(
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: selectMeal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          selectMeal.ingredients[index],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    );
                  }),
            ),
            _buildSelectionTitle(context, 'Steps'),
            _buildContainer(
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: selectMeal.steps.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('#${index + 1}'),
                          ),
                          title: Text(
                            selectMeal.steps[index],
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                          color: Color(0xFFE0E0E0),
                        )
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        // () {
        //   // Navigator.of(context).pop(mealId);
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       // action: SnackBarAction(
        //       //   label: 'Action',
        //       //   onPressed: () {
        //       //     // Code to execute.
        //       //   },
        //       // ),
        //       content: Text('you added ${selectMeal.title} in your favorite'),
        //       duration: const Duration(milliseconds: 1500),
        //       width: 280.0, // Width of the SnackBar.
        //       padding: const EdgeInsets.symmetric(
        //         horizontal: 8.0, // Inner padding for SnackBar content.
        //       ),
        //       behavior: SnackBarBehavior.floating,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(10.0),
        //       ),
        //     ),
        //   );
        // },
        child: Icon(isFavorite(mealId)
            ? Icons.favorite
            : Icons.favorite_border_outlined),
      ),
    );
  }
}
