import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static final String routeName = '/meal-screen';
  final Function toggleFavourites;
  final Function isFavourite;
  MealDetailScreen(this.toggleFavourites, this.isFavourite);

  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: Theme.of(ctx).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        height: 150,
        width: 300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealIdMap =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final mealId = mealIdMap['id'];

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

   
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index])),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${(index + 1)}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(thickness: 1, color: Colors.grey)
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavourites(mealId),
        child: Icon(
          isFavourite(mealId) ? Icons.star : Icons.star_border,
          color: Colors.black,
        ),
      ),
    );
  }
}
